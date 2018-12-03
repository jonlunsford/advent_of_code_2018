defmodule Checksum do
  @moduledoc """
  Advent Of Code Day 02 Part 1

  https://adventofcode.com/2018/day/2

  run tests with: elixir calibrator.ex

  Get answer within iex shell:
    > import_file("checksum.ex")
    > Checksum.run("input.txt")
    > ???
  """

  def run(%File.Stream{} = file_stream) do
    file_stream
    |> Enum.reduce([0, 0], fn(line, [sum_a, sum_b]) ->
      [(find_duplicates(line, 2) + sum_a), (find_duplicates(line, 3) + sum_b)]
    end)
    |> Enum.reduce(&(&1 * &2))
  end

  def run(file) when is_binary(file) do
    file
    |> File.stream!([], :line)
    |> run()
  end

  def find_duplicates(string, count) do
    string
    |> String.graphemes()
    |> Enum.sort()
    |> Enum.chunk_by(fn arg -> arg end)
    |> Enum.map(fn arg -> to_string(arg) end)
    |> Enum.reduce(0, fn(arg, acc) ->
      if(String.length(arg) == count && acc == 0) do
        acc + 1
      else
        acc
      end
    end)
  end
end

ExUnit.start()

defmodule ChecksumTest do
  use ExUnit.Case

  setup do
    file_name = "input-test.txt"
    File.write!(file_name, "abcdef\nbababc\nabbcde\nabcccd\naabcdd\nabcdee\nababab\n")
    {:ok, %{file_name: file_name}}
  end

  describe ".run" do
    test "it finds duplicates of 2 and 3 and multiplies the results", %{file_name: file_name} do
      assert Checksum.run(file_name) == 12
    end
  end

  describe ".find_duplicates" do
    test "it returns 1 for a string that has exactly 2 duplicate letters" do
      assert Checksum.find_duplicates("abbcde", 2) == 1
    end

    test "it returns 1 for a string that has 2 occurrences of duplicate letters" do
      assert Checksum.find_duplicates("ababab", 3) == 1
    end

    test "it returns 1 for a string that has n occurrences of duplicate letters" do
      assert Checksum.find_duplicates("abbccccdebb", 4) == 1
    end

    test "it returns 0 if no duplicates are found" do
      assert Checksum.find_duplicates("abcdef", 2) == 0
    end
  end
end
