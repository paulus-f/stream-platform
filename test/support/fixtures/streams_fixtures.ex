defmodule HomeServiceStreaming.StreamsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HomeServiceStreaming.Streams` context.
  """

  @doc """
  Generate a stream.
  """
  def stream_fixture(attrs \\ %{}) do
    {:ok, stream} =
      attrs
      |> Enum.into(%{
        title: "some title"
      })
      |> HomeServiceStreaming.Streams.create_stream()

    stream
  end
end
