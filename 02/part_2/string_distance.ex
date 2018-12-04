defmodule StringDistance do
  @moduledoc """
  Advent Of Code Day 02 Part 2

  https://adventofcode.com/2018/day/2

  run tests with: elixir calibrator.ex

  Get answer within iex shell:
    > import_file("string_distance.ex")
    > StringDistance.run("input.txt")
    > ???
  """

  def run(file) when is_binary(file) do
    file
    |> File.stream!([], :line)
    |> Enum.to_list()
    |> closest()
  end

  def closest(input) when is_list(input) do
    input
    |> Enum.map(&String.to_charlist/1)
    |> find_charlist()
  end

  def find_charlist([head | tail]) do
    if closest = Enum.find(tail, &closest_charlist(&1, head)) do
      head
      |> Enum.zip(closest)
      |> Enum.filter(fn {left, right} -> left == right end)
      |> Enum.map(fn {left, _} -> left end)
      |> List.to_string()
    else
      find_charlist(tail)
    end
  end

  defp closest_charlist(left, right) do
    left
    |> Enum.zip(right)
    |> Enum.count(fn {left_point, right_point} ->
      left_point != right_point
    end)
    |> case do
      1 -> true
      _ -> false
    end
  end
end

ExUnit.start()

defmodule StringDistanceTest do
  use ExUnit.Case

  test "it returns strings that are different by only on char" do
    assert StringDistance.closest([
             "abcde",
             "fghij",
             "klmno",
             "pqrst",
             "fguij",
             "axcye",
             "wvxyz"
           ]) == "fgij"
  end
end
