defmodule RtmpServer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false
  use Application

  alias Membrane.RTMP.Source.TcpServer

  @port 9006
  @local_ip {127, 0, 0, 1}

  @impl true
  def start(_type, _args) do
    File.mkdir_p("output")

    # tcp_server_options = %TcpServer{
    #   port: @port,
    #   listen_options: [
    #     :binary,
    #     packet: :raw,
    #     active: false,
    #     ip: @local_ip
    #   ],
    #   socket_handler: fn socket ->
    #     {:ok, _sup, pid} = RtmpServer.StreamProcess.start_link(socket: socket)
    #     {:ok, pid}
    #   end
    # }

    children = [
      # Start the Tcp Server
      # RTMP server,
      # %{
      #   id: TcpServer,
      #   start: {TcpServer, :start_link, [tcp_server_options]}
      # },
      # Start the Telemetry supervisor
      RtmpServerWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: RtmpServer.PubSub},
      # Start Finch
      {Finch, name: RtmpServer.Finch},
      # Start the Endpoint (http/https)
      RtmpServerWeb.Endpoint
      # Start a worker by calling: RtmpServer.Worker.start_link(arg)
      # {RtmpServer.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RtmpServer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RtmpServerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
