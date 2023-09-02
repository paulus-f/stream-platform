defmodule RtmpServerWeb.StreamActionController do
  use RtmpServerWeb, :controller

  alias Plug

  @port 9006

  def start(conn, %{"id" => id}) do
    path = "output/#{id}"

    RTMP.Receiver.run(port: @port, path: path)

    json(conn, %{status: :ok, path: path})
  end
end
