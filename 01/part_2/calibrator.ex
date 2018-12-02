defmodule Calibrator do
  @type accumulator() :: Integer.t()

  @moduledoc """
  Advent of Code day 1 PART 2

  https://adventofcode.com/2018/day/1

  run tests with: elixir calibrator.ex

  Note, your input data will be different than what's in this repo.

  Get answer within iex shell:
    > import_file("calibrator.ex")
    > Calibrator.run("input.txt")
    > ???
  """

  def run(%File.Stream{} = file_stream) do
    file_stream
    |> Stream.map(fn(line) ->
      {integer, _other} = Integer.parse(line)
      integer
    end)
    |> Stream.cycle()
    |> Enum.reduce_while({0, MapSet.new([0])}, fn(acc, {cur_freq, seen_freq}) ->
      new_freq = cur_freq + acc

      if new_freq in seen_freq do
        {:halt, new_freq}
      else
        {:cont, {new_freq, MapSet.put(seen_freq, new_freq)}}
      end
    end)
  end

  def run(path) when is_binary(path) do
    path
    |> File.stream!([], :line)
    |> Calibrator.run()
  end
end

ExUnit.start()

defmodule CalibratorTest do
  use ExUnit.Case

  setup do
    file_name = "input-test.txt"
    File.write(file_name, "+1\n-2\n+3\n+1\n")
    {:ok, %{file_name: file_name}}
  end

  describe ".run" do
    test "returns repeated occurrences of integers", %{file_name: file_name} do
      assert Calibrator.run(file_name) == 2
    end
  end
end
