defmodule HomeServiceStreaming.Streams do
  @moduledoc """
  The Streams context.
  """

  import Ecto.Query, warn: false
  alias HomeServiceStreaming.Repo

  alias HomeServiceStreaming.Streams.Stream

  @doc """
  Returns the list of streams.

  ## Examples

      iex> list_streams()
      [%Stream{}, ...]

  """
  def list_streams do
    Repo.all(Stream)
  end

  @doc """
  Gets a single stream.

  Raises `Ecto.NoResultsError` if the Stream does not exist.

  ## Examples

      iex> get_stream!(123)
      %Stream{}

      iex> get_stream!(456)
      ** (Ecto.NoResultsError)

  """
  def get_stream!(id), do: Repo.get!(Stream, id)

  @doc """
  Creates a stream.

  ## Examples

      iex> create_stream(%{field: value})
      {:ok, %Stream{}}

      iex> create_stream(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_stream(attrs \\ %{}) do
    %Stream{}
    |> Stream.changeset(attrs)
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
  def update_stream(%Stream{} = stream, attrs) do
    stream
    |> Stream.changeset(attrs)
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
  def delete_stream(%Stream{} = stream) do
    Repo.delete(stream)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking stream changes.

  ## Examples

      iex> change_stream(stream)
      %Ecto.Changeset{data: %Stream{}}

  """
  def change_stream(%Stream{} = stream, attrs \\ %{}) do
    Stream.changeset(stream, attrs)
  end
end
