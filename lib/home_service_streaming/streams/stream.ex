defmodule HomeServiceStreaming.Streams.Stream do
  use Ecto.Schema
  import Ecto.Changeset

  alias HomeServiceStreaming.Messages.Message

  schema "streams" do
    field :title, :string
    has_many :messages, Message

    timestamps()
  end

  @doc false
  def changeset(stream, attrs) do
    stream
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
