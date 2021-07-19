defmodule ChartsLive.LineViewTest do
  @moduledoc false

  use ExUnit.Case

  import ChartsLive.LineView

  alias Charts.LineChart.Point

  describe "svg_polyline_points/1" do
    test "should return empty string" do
      assert svg_polyline_points([]) == ""
    end

    test "should convert points to polyline points" do
      points = [
        %Point{label: "a", fill_color: "red", x_offset: 0.0, y_offset: 0.0},
        %Point{label: "a", fill_color: "red", x_offset: 10.0, y_offset: 5.0}
      ]

      assert svg_polyline_points(points) == "0.0,1000 0.0,1.0e3 100.0,950.0 100.0,1000"
    end
  end
end
