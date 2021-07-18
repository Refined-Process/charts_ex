defmodule Charts.Axes.MagnitudeAxisTest do
  @moduledoc false

  alias Charts.Axes.MagnitudeAxis
  use ExUnit.Case

  describe "default_grid_lines_fun/2" do
    test "returns default grid lines" do
      min_max = {0, 2500}

      assert MagnitudeAxis.default_grid_lines_fun(min_max, 10) == [
               250,
               500,
               750,
               1000,
               1250,
               1500,
               1750,
               2000,
               2250,
               2500
             ]
    end
  end
end
