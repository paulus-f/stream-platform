defmodule HomeServiceStreaming.Repo.Migrations.UpdateStreamsTable do
  use Ecto.Migration

  def change do
    alter table(:streams) do
      add :stream_key, :string
      add :description, :text
      add :start_time, :text
      add :end_time, :text
      add :thumbnail, :string
      add :viewers, :integer
      add :status, :integer
      add :user_id, references(:users)
    end
  end
end
