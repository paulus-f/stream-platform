require Logger

defmodule HomeServiceStreamingWeb.StreamLive.Show do
  use HomeServiceStreamingWeb, :live_view
  #use HTTPoison

  alias HomeServiceStreaming.Messages
  alias HomeServiceStreaming.Streams

  @impl true
  def mount(%{"id" => id}, session, socket) do
    base_path = Application.get_env(:rtmp_server, :output)
    Application.get_env(:rtmp_server, :endpoint)

    stream_path = Path.join([base_path, id, "index.m3u8"])

    started? = case File.stat(stream_path) do
      {:ok, _} -> true
      _ -> true
    end

    socket = assign_defaults(session, socket)

    socket =
      socket
      |> assign(:page_title, page_title(socket.assigns.live_action))
      |> assign(:current_user, socket.assigns.current_user)
      |> assign(:id, id)
      |> assign(:stream, Streams.get_stream!(id))
      |> assign(:messages, Messages.get_messages_by_stream!(id))
      |> assign(
        type_body_tag: "video",
        immersive?: true,
        live?: false,
        started?: started?, #started?
        rtmp_endpoint: Application.get_env(:rtmp_server, :endpoint) <> "/" <> id <> "/" <> Application.get_env(:rtmp_server, :video_stream)
      )

    id
    |> chat_topic
    |> HomeServiceStreamingWeb.Endpoint.subscribe()

    {:ok, socket}
  end

  @impl true
  def handle_event("send-stream-chat-message", %{"text" => text}, socket) do
    message = %{
      body: text,
      user: socket.assigns.current_user,
      user_id: socket.assigns.current_user.id,
      stream_id: socket.assigns.stream.id,
      stream: socket.assigns.stream
    }

    topic = chat_topic(socket.assigns.id)
    messages = Messages.create_and_get_messages_by_stream!(message, socket.assigns.id)

    HomeServiceStreamingWeb.Endpoint.broadcast(topic, "new-stream-chat-message", messages)

    {:noreply, socket}
  end

  @impl true
  def handle_info(%{event: "new-stream-chat-message", payload: messages}, socket) do
    Logger.info("--------------------------------------------")
    Logger.info("handle_info logger: #{inspect(messages)}")
    Logger.info("--------------------------------------------")

    {:noreply, assign(socket, messages: messages)}
  end

  @impl true
  def handle_event("start-stream", %{"stream_id" => stream_id}, socket) do
    Logger.info("--------------------------------------------")
    Logger.info("handle_info logger: START STREAM - #{stream_id}")
    Logger.info("--------------------------------------------")

    # TODO: Add request to rtmp server app
    case HTTPoison.get("https://postman-echo.com/get") do
      {:ok, response} ->
        Logger.info("--------------------------------------------")
        Logger.info("The stream #{stream_id} has started successfully")
        Logger.info("--------------------------------------------")

        {:noreply, socket}
      {:error, reason} ->
        Logger.info("--------------------------------------------")
        Logger.info("There is failure to start stream #{stream_id}")
        Logger.info("--------------------------------------------")

        {:noreply, socket}
    end
  end

  # @impl true
  # def handle_info(%{event: "stop-stream", payload: stream_id}, socket) do
  #   Logger.info("--------------------------------------------")
  #   Logger.info("handle_info logger: STOP STREAM - #{stream_id}")
  #   Logger.info("--------------------------------------------")

  #   {:noreply, assign(socket)}
  # end

  defp chat_topic(id) do
    "stream_chat_#{id}"
  end

  defp page_title(:show), do: "Show Stream"
  defp page_title(:edit), do: "Edit Stream"
end
