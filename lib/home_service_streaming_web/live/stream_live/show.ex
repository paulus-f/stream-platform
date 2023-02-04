defmodule HomeServiceStreamingWeb.StreamLive.Show do
  use HomeServiceStreamingWeb, :live_view

  alias HomeServiceStreaming.Streams

  @impl true
  def mount(_params, session, socket) do
    {:ok, assign_defaults(session, socket)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:stream, Streams.get_stream!(id))}
  end

  @impl true
  def handle_event("send", %{"text" => text}, socket) do
    HomeServiceStreamingWeb.Endpoint.broadcast(topic(), "message", %{
      text: text,
      name: socket.assigns.username
    })

    {:noreply, socket}
  end

  defp username, do: "User #{:rand.uniform(100)}"
  defp topic, do: "chat"
  defp page_title(:show), do: "Show Stream"
  defp page_title(:edit), do: "Edit Stream"
end
