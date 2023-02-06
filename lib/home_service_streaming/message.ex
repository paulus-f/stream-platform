defmodule HomeServiceStreaming.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :body, :string

    belongs_to :stream, HomeServiceStreaming.Streams
    belongs_to :user, HomeServiceStreaming.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [])
    |> validate_required([])
  end
end
