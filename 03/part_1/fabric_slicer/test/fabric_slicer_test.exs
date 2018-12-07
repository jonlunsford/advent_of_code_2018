defmodule FabricSlicerTest do
  use ExUnit.Case
  doctest FabricSlicer

  test "parse_claim" do
    assert FabricSlicer.parse_claim("#1 @ 1,3: 4x4") == [1, 1, 3, 4, 4]
  end

  test "claim_inches" do
    claimed =
      FabricSlicer.claim_inches([
        "#1 @ 1,3: 4x4",
        "#2 @ 3,1: 4x4",
        "#3 @ 5,5: 2x2"
      ])

    assert claimed[{4, 2}] == [2]
  end

  test "get_overlap" do
    assert FabricSlicer.get_overlap([
             "#1 @ 1,3: 4x4",
             "#2 @ 3,1: 4x4",
             "#3 @ 5,5: 2x2"
           ])
           |> Enum.sort() == [{4, 4}, {4, 5}, {5, 4}, {5, 5}]
  end
end
