defmodule HomeServiceStreaming.Messages.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :body, :string

    belongs_to :stream, HomeServiceStreaming.Streams.Stream
    belongs_to :user, HomeServiceStreaming.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:body, :stream_id, :user_id])
    |> validate_required([:body, :stream_id, :user_id])
  end
end
