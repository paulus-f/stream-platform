defmodule HomeServiceStreaming.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :body, :text
      add :stream_id, references(:streams)
      add :user_id, references(:users)
      timestamps()
    end
  end
end
