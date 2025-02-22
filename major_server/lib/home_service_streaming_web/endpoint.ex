defmodule HomeServiceStreamingWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :home_service_streaming

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  @session_options [
    store: :cookie,
    key: "_home_service_streaming_key",
    signing_salt: "KHVSS7gH"
  ]

  socket "/live", Phoenix.LiveView.Socket, websocket: [connect_info: [session: @session_options]]

  # TODO: To Fix
  # plug Corsica,
  # origins: [
  #   "http://localhost:4000",
  #   "http://localhost:8000",
  #   "http://localhost:8080"
  # ],
  # allow_headers: ["accept", "content-type", "authorization"],
  # allow_credentials: true,
  # log: [rejected: :error, invalid: :warn, accepted: :debug]
  plug Corsica, origins: "*", allow_credentials: true

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :home_service_streaming,
    gzip: false,
    only: ~w(assets fonts images favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :home_service_streaming
  end

  plug Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug HomeServiceStreamingWeb.Router
end
