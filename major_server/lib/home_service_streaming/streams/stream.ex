defmodule HomeServiceStreaming.Streams.Stream do
  use Ecto.Schema
  import Ecto.Changeset

  alias HomeServiceStreaming.Messages.Message
  alias HomeServiceStreaming.Accounts.User

  schema "streams" do
    field :title, :string
    field :stream_key, :string
    field :description, :string
    # TODO change type on naive_datetime
    # field :start_time, :text
    # TODO change type on naive_datetime
    # field :end_time, :text
    field :thumbnail, :string
    field :viewers, :integer
    field :status, :integer

    has_many :messages, Message

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(stream, attrs) do
    stream
    |> cast(attrs, [:title, :user_id])
    |> validate_required([:title, :user_id])
  end
end
