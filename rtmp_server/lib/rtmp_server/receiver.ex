defmodule RTMP.Receiver do
  @server_ip {127, 0, 0, 1}

  # TODO:
  # - to read about supervision https://hexdocs.pm/elixir/Supervisor.html
  # - how pid of Receivers can be store (database or via file)
  # - add endpoint which creating receivers pid
  # - add endpoint which removing receivers pid

  def run(port: port, path: path) do
    parent = self()

    server_options = %Membrane.RTMP.Source.TcpServer{
      port: port,
      listen_options: [
        :binary,
        packet: :raw,
        active: false,
        ip: @server_ip
      ],
      socket_handler: fn socket ->
        # On new connection a pipeline is started
        {:ok, _supervisor, pipeline} = = RtmpServer.StreamProcess.start_link(socket: socket, path: path)

        send(parent, {:pipeline_spawned, pipeline})

        {:ok, pipeline}
      end
    }

    {:ok, pipeline} = start_server(server_options)

    await_termination(pipeline)
  end

  defp start_server(server_options) do
    {:ok, _server_pid} = Membrane.RTMP.Source.TcpServer.start_link(server_options)

    receive do
      {:pipeline_spawned, pipeline} ->
        {:ok, pipeline}
    end
  end

  defp await_termination(pipeline) do
    monitor_ref = Process.monitor(pipeline)

    receive do
      {:DOWN, ^monitor_ref, :process, _pid, _reason} ->
        :ok
    end
  end
end
