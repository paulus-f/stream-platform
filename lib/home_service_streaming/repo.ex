defmodule HomeServiceStreaming.Repo do
  use Ecto.Repo,
    otp_app: :home_service_streaming,
    adapter: Ecto.Adapters.Postgres
end
