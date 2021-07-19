defmodule Charts.BaseChartTest do
  @moduledoc false

  alias Charts.{
    BaseChart,
    BaseDatum,
    Chart,
    BarChart,
    Gradient
  }

  alias Charts.Axes.{BaseAxes, MagnitudeAxis}
  use ExUnit.Case

  @y_axis %MagnitudeAxis{min: 0, max: 2500}
  @axes %BaseAxes{magnitude_axis: @y_axis}
  @data [
    %BaseDatum{name: "Bar One", values: [750]},
    %BaseDatum{name: "Bar Two", values: [1500]},
    %BaseDatum{name: "Bar Three", values: [2500]},
    %BaseDatum{name: "Bar Four", values: [750]},
    %BaseDatum{name: "Bar Five", values: [1750]}
  ]
  @dataset %BarChart.Dataset{data: @data, axes: @axes}
  @chart %BaseChart{title: "title", dataset: @dataset}

  describe "title/1" do
    test "returns the title of the chart" do
      assert Chart.title(@chart) == @chart.title
    end

    test "returns an empty string if title is nil" do
      assert Chart.title(%BaseChart{}) == ""
    end
  end

  describe "colors/1" do
    test "returns empty tuple by default" do
      chart = %BaseChart{colors: nil}

      assert Chart.colors(chart) == {}
    end

    test "returns all colors" do
      colors = %{
        blue: "#0011FF",
        red: "#FF0000"
      }

      chart = %BaseChart{colors: colors}

      assert Chart.colors(chart) == colors
    end
  end

  describe "gradient_colors/1" do
    test "returns empty map by default" do
      chart = %BaseChart{colors: nil}

      assert Chart.gradient_colors(chart) == %{}
    end

    test "returns only gradient colors" do
      expected_gradient_colors = %{
        blue_gradient: %Gradient{
          start_color: "#0011FF",
          end_color: "#1100FF"
        }
      }

      colors = Map.put(expected_gradient_colors, :red, "#FF0000")
      chart = %BaseChart{title: "title", dataset: @dataset, colors: colors}

      assert Chart.gradient_colors(chart) == expected_gradient_colors
    end
  end
end
