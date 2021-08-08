defmodule Charts.StackedBarChartTest do
  @moduledoc false

  alias Charts.{
    BaseChart,
    BaseDatum,
    StackedBarChart,
    StackedColumnChart.Rectangle
  }

  alias Charts.Axes.{BaseAxes, MagnitudeAxis}
  use ExUnit.Case

  @y_axis %MagnitudeAxis{min: 0, max: 300}
  @axes %BaseAxes{magnitude_axis: @y_axis}
  @data [
    %BaseDatum{
      name: "column 1",
      values: %{blueberry: 1, orange: 5, apple: 10, watermelon: 15, banana: 20}
    },
    %BaseDatum{
      name: "column 2",
      values: %{blueberry: 50, orange: 40, apple: 30, watermelon: 20, banana: 10}
    },
    %BaseDatum{
      name: "column 3",
      values: %{blueberry: 3, orange: 4, apple: 5, watermelon: 1, banana: 2}
    },
    %BaseDatum{
      name: "column 4",
      values: %{blueberry: 50, orange: 40, apple: 30, watermelon: 20, banana: 10}
    },
    %BaseDatum{
      name: "column 5",
      values: %{blueberry: 1, orange: 5, apple: 10, watermelon: 15, banana: 20}
    }
  ]
  @colors %{
    blueberry: "#4096EE",
    orange: "#FF7400",
    apple: "#CC0000",
    watermelon: "#008C00",
    banana: "#FFFF88"
  }
  @dataset %Charts.BarChart.Dataset{data: @data, axes: @axes}
  @chart %BaseChart{title: "title", dataset: @dataset, colors: @colors}

  describe "rows/1" do
    test "returns the number of rows that make up the dataset" do
      assert length(StackedBarChart.rows(@chart)) == length(@data)
    end

    test "returns row labels" do
      rows = Enum.map(StackedBarChart.rows(@chart), & &1.label)
      labels = Enum.map(@data, & &1.name)

      assert rows
             |> Enum.zip(labels)
             |> Enum.all?(fn {actual, expected} -> actual == expected end)
    end

    test "returns evenly distributed row heights" do
      row_heights = Enum.map(StackedBarChart.rows(@chart), & &1.height)
      expected_row_height = 20.0

      assert Enum.all?(row_heights, fn row_height -> row_height == expected_row_height end)
    end

    test "returns multi_bar height as half of bar height" do
      row_heights = Enum.map(StackedBarChart.rows(@chart), & &1.bar_height)
      expected_bar_height = 10.0

      assert Enum.all?(row_heights, fn row_height -> row_height == expected_bar_height end)
    end

    test "returns correct row offsets" do
      row_offsets = Enum.map(StackedBarChart.rows(@chart), & &1.offset)
      expected_row_offsets = [0.0, 20.0, 40.0, 60.0, 80.0]

      assert row_offsets == expected_row_offsets
    end

    test "returns bar_offsets with margins taken into account" do
      bar_offsets = Enum.map(StackedBarChart.rows(@chart), & &1.bar_offset)
      expected_row_offsets = [5.0, 25.0, 45.0, 65.0, 85.0]

      assert bar_offsets == expected_row_offsets
    end

    test "calculates row width as a percent of x-axis max value" do
      bar_widths = Enum.map(StackedBarChart.rows(@chart), & &1.bar_width)
      expected_bar_widths = [17.0, 50.0, 5.0, 50.0, 17.0]

      assert bar_widths == expected_bar_widths
    end
  end

  describe "rectangles/1" do
    test "returns the correct number of rectangles" do
      assert length(StackedBarChart.rectangles(@chart)) == 25
    end

    test "returns the first rectangle correctly" do
      [first | _] = StackedBarChart.rectangles(@chart)

      expected = %Rectangle{
        fill_color: :watermelon,
        height: 20.0,
        label: 15,
        width: 5.0,
        x_offset: 12.000000000000004,
        y_offset: 5.0
      }

      assert first == expected
    end
  end
end
