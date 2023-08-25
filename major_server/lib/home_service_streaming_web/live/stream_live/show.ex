require Logger

defmodule HomeServiceStreamingWeb.StreamLive.Show do
  use HomeServiceStreamingWeb, :live_view

  alias HomeServiceStreaming.Messages
  alias HomeServiceStreaming.Streams

  @impl true
  def mount(%{"id" => id}, session, socket) do
    # index_path = Path.join(["/live_stream", id, "index.m3u8"])
    # local_path = Path.join("priv/static/", index_path)
    # # started? = case File.stat(local_path) do
    #   {:ok, _} -> true
    #   _ -> true
    # end

    # Phoenix.PubSub.subscribe(HomeServiceStreamingWeb.PubSub, "live_stream:#{id}")

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
        started?: false #started?
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

  @impl false
  def handle_info(:started, socket) do
    {:noreply, assign(socket, started?: true, live?: true)}
  end

  @impl false
  def handle_info(:ended, socket) do
    {:noreply, assign(socket, started?: true, live?: false)}
  end

  defp chat_topic(id) do
    "stream_chat_#{id}"
  end

  defp page_title(:show), do: "Show Stream"
  defp page_title(:edit), do: "Edit Stream"
end
