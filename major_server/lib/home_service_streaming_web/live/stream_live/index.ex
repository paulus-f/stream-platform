defmodule HomeServiceStreamingWeb.StreamLive.Index do
  use HomeServiceStreamingWeb, :live_view

  alias HomeServiceStreaming.Streams
  alias HomeServiceStreaming.Streams.Stream

  @impl true
  def mount(_params, session, socket) do
    socket = assign_defaults(session, socket)

    {:ok, assign(socket, :streams, list_streams())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Stream")
    |> assign(:stream, Streams.get_stream!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Stream")
    |> assign(:user_id, socket.assigns.current_user.id)
    |> assign(:stream, %Stream{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Streams")
    |> assign(:stream, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    stream = Streams.get_stream!(id)
    {:ok, _} = Streams.delete_stream(stream)

    {:noreply, assign(socket, :streams, list_streams())}
  end

  defp list_streams do
    Streams.list_streams()
  end
end
