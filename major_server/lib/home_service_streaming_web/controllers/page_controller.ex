defmodule HomeServiceStreamingWeb.PageController do
  use HomeServiceStreamingWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
