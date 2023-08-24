defmodule HomeServiceStreaming.Repo.Migrations.CreateStreams do
  use Ecto.Migration

  def change do
    create table(:streams) do
      add :title, :string

      timestamps()
    end
  end
end
