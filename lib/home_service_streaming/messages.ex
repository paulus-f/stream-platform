require Logger

defmodule HomeServiceStreaming.Messages do
  @moduledoc """
  The Streams context.
  """

  import Ecto.Query, warn: false
  alias HomeServiceStreaming.Repo

  alias HomeServiceStreaming.Messages.Message

  @doc """
  Returns the list of streams.

  ## Examples

      iex> list_streams()
      [%Stream{}, ...]

  """
  def list_messages do
    Repo.all(Message)
  end

  @doc """
  Gets a single stream.

  Raises `Ecto.NoResultsError` if the Stream does not exist.

  ## Examples

      iex> get_stream!(123)
      %Stream{}

      iex> get_stream!(456)
      ** (Ecto.NoResultsError)śś

  """
  def get_message!(id), do: Repo.get!(Message, id)

  def get_messages_by_stream!(id) do
    Message
    |> where(stream_id: ^id)
    |> order_by(desc: :id)
    |> Repo.all()
    |> Repo.preload([:user, :stream])
  end

  @doc """
  Creates a stream.

  ## Examples

      iex> create_stream(%{field: value})
      {:ok, %Stream{}}

      iex> create_stream(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_message(attrs \\ %{}) do
    Logger.info("Create message attrs: #{inspect(attrs)}")

    %Message{
      stream: attrs[:stream],
      user: attrs[:user]
    }
    |> Message.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a stream.

  ## Examples

      iex> update_stream(stream, %{field: new_value})
      {:ok, %Stream{}}

      iex> update_stream(stream, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_message(%Message{} = message, attrs) do
    message
    |> Message.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a stream.

  ## Examples

      iex> delete_stream(stream)
      {:ok, %Stream{}}

      iex> delete_stream(stream)
      {:error, %Ecto.Changeset{}}

  """
  def delete_message(%Message{} = message) do
    Repo.delete(message)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking stream changes.

  ## Examples

      iex> change_stream(stream)
      %Ecto.Changeset{data: %Stream{}}

  """
  def change_message(%Message{} = message, attrs \\ %{}) do
    Stream.changeset(message, attrs)
  end
end
