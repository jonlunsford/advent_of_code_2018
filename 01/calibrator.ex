defmodule Calibrator do
  @type accumulator() :: Integer.t()

  @moduledoc """
  Helps calibrate frequency drift after traveling through time to SAVE CHRISTMAS!!!

  https://adventofcode.com/2018/day/1

  run tests with: elixir calibrator.ex

  Get answer within iex shell:
    > import_file("calibrator.ex")
    > Calibrator.run_with_file("input.txt", 0)
    > ???
  """

  @spec run([pos_integer() | neg_integer()], accumulator()) :: pos_integer() | neg_integer()
  def run([head | tail], acc) do
    run(tail, acc + head)
  end

  @spec run([], accumulator()) :: accumulator()
  def run([], acc), do: acc

  @spec run_with_file(String.t(), accumulator()) :: pos_integer() | neg_integer()
  def run_with_file(path, acc) do
    case File.read(path) do
      {:ok, raw_file} ->
        raw_file
        |> String.split("\n", trim: true)
        |> Enum.map(fn(i) -> String.to_integer(i) end)
        |> run(acc)
      {:error, reason} ->
        {:error, reason }
    end
  end
end

ExUnit.start()

defmodule CalibratorTest do
  use ExUnit.Case

  describe ".run" do
    test "it increments an accumulator" do
      assert Calibrator.run([+2], 0) == 2
    end

    test "it decrements an accumulator" do
      assert Calibrator.run([-2], 2) == 0
    end

    test "it modifies an accumulator recursively" do
      assert Calibrator.run([+1, +2, -1], 0) == 2
    end
  end

  describe ".run_with_file" do
    test "it reads input from a text file" do
      test_file_name = "input-test.txt"
      File.write(test_file_name, "+1\n+2\n-1\n")

      assert Calibrator.run_with_file(test_file_name, 0) == 2
    end
  end
end
