defmodule HomeServiceStreaming.Streams.Stream do
  use Ecto.Schema
  import Ecto.Changeset

  schema "streams" do
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(stream, attrs) do
    stream
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
