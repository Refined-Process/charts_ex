defmodule Charts.StackedColumnChartTest do
  @moduledoc false

  alias Charts.{
    BaseChart,
    BaseDatum,
    StackedColumnChart,
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

  describe "columns/1" do
    test "returns the number of columns that make up the dataset" do
      assert length(StackedColumnChart.columns(@chart)) == length(@data)
    end

    test "returns column labels" do
      columns = Enum.map(StackedColumnChart.columns(@chart), & &1.label)
      labels = Enum.map(@data, & &1.name)

      assert columns
             |> Enum.zip(labels)
             |> Enum.all?(fn {actual, expected} -> actual == expected end)
    end

    test "returns evenly distributed column widths" do
      column_widths = Enum.map(StackedColumnChart.columns(@chart), & &1.width)
      expected_column_width = 20.0

      assert Enum.all?(column_widths, fn column_width -> column_width == expected_column_width end)
    end

    test "returns bar widths as half of column widths" do
      bar_widths = Enum.map(StackedColumnChart.columns(@chart), & &1.bar_width)
      expected_bar_width = 10.0

      assert Enum.all?(bar_widths, fn bar_width -> bar_width == expected_bar_width end)
    end

    test "returns correct column offsets" do
      column_offsets = Enum.map(StackedColumnChart.columns(@chart), & &1.offset)
      expected_column_offsets = [0.0, 20.0, 40.0, 60.0, 80.0]

      assert column_offsets == expected_column_offsets
    end

    test "returns bar_offsets with margins taken into account" do
      bar_offsets = Enum.map(StackedColumnChart.columns(@chart), & &1.bar_offset)
      expected_bar_offsets = [5.0, 25.0, 45.0, 65.0, 85.0]

      assert bar_offsets == expected_bar_offsets
    end

    test "calculates column height as a percent of y-axis max value" do
      column_heights = Enum.map(StackedColumnChart.columns(@chart), & &1.column_height)
      expected_column_heights = [17.0, 50.0, 5.0, 50.0, 17.0]

      assert column_heights == expected_column_heights
    end
  end

  describe "rectangles/1" do
    test "returns the correct number of rectangles" do
      assert length(StackedColumnChart.rectangles(@chart)) == 25
    end

    test "returns the first rectangle correctly" do
      [first | _] = StackedColumnChart.rectangles(@chart)

      expected = %Rectangle{
        fill_color: :watermelon,
        height: 5.0,
        label: 15,
        width: 20.0,
        x_offset: 5.0,
        y_offset: 83
      }

      assert first == expected
    end
  end
end
