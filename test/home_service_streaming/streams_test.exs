defmodule HomeServiceStreaming.StreamsTest do
  use HomeServiceStreaming.DataCase

  alias HomeServiceStreaming.Streams

  describe "streams" do
    alias HomeServiceStreaming.Streams.Stream

    import HomeServiceStreaming.StreamsFixtures

    @invalid_attrs %{title: nil}

    test "list_streams/0 returns all streams" do
      stream = stream_fixture()
      assert Streams.list_streams() == [stream]
    end

    test "get_stream!/1 returns the stream with given id" do
      stream = stream_fixture()
      assert Streams.get_stream!(stream.id) == stream
    end

    test "create_stream/1 with valid data creates a stream" do
      valid_attrs = %{title: "some title"}

      assert {:ok, %Stream{} = stream} = Streams.create_stream(valid_attrs)
      assert stream.title == "some title"
    end

    test "create_stream/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Streams.create_stream(@invalid_attrs)
    end

    test "update_stream/2 with valid data updates the stream" do
      stream = stream_fixture()
      update_attrs = %{title: "some updated title"}

      assert {:ok, %Stream{} = stream} = Streams.update_stream(stream, update_attrs)
      assert stream.title == "some updated title"
    end

    test "update_stream/2 with invalid data returns error changeset" do
      stream = stream_fixture()
      assert {:error, %Ecto.Changeset{}} = Streams.update_stream(stream, @invalid_attrs)
      assert stream == Streams.get_stream!(stream.id)
    end

    test "delete_stream/1 deletes the stream" do
      stream = stream_fixture()
      assert {:ok, %Stream{}} = Streams.delete_stream(stream)
      assert_raise Ecto.NoResultsError, fn -> Streams.get_stream!(stream.id) end
    end

    test "change_stream/1 returns a stream changeset" do
      stream = stream_fixture()
      assert %Ecto.Changeset{} = Streams.change_stream(stream)
    end
  end
end
