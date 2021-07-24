defmodule Charts.ColumnChartTest do
  @moduledoc false

  alias Charts.{
    BaseChart,
    BaseDatum,
    ColumnChart
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
  @dataset %Charts.ColumnChart.Dataset{data: @data, axes: @axes}
  @chart %BaseChart{title: "title", dataset: @dataset}

  describe "columns/1" do
    test "returns the number of columns that make up the dataset" do
      assert length(ColumnChart.columns(@chart)) == length(@data)
    end

    test "returns column labels" do
      columns = Enum.map(ColumnChart.columns(@chart), & &1.label)
      labels = Enum.map(@data, & &1.name)

      assert columns
             |> Enum.zip(labels)
             |> Enum.all?(fn {actual, expected} -> actual == expected end)
    end

    test "returns evenly distributed column widths" do
      column_widths = Enum.map(ColumnChart.columns(@chart), & &1.width)
      expected_column_width = 20.0

      assert Enum.all?(column_widths, fn column_width -> column_width == expected_column_width end)
    end

    test "returns bar widths as half of column widths" do
      column_widths = Enum.map(ColumnChart.columns(@chart), & &1.column_width)
      expected_column_width = 10.0

      assert Enum.all?(column_widths, fn column_width -> column_width == expected_column_width end)
    end

    test "returns correct column offsets" do
      column_offsets = Enum.map(ColumnChart.columns(@chart), & &1.offset)
      expected_column_offsets = [0.0, 20.0, 40.0, 60.0, 80.0]

      assert column_offsets == expected_column_offsets
    end

    test "returns column_offsets with margins taken into account" do
      column_offsets = Enum.map(ColumnChart.columns(@chart), & &1.column_offset)
      expected_column_offsets = [5.0, 25.0, 45.0, 65.0, 85.0]

      assert column_offsets == expected_column_offsets
    end

    test "calculates column height as a percent of y-axis max value" do
      column_heights = Enum.map(ColumnChart.columns(@chart), & &1.column_height)
      expected_column_heights = [30.0, 60.0, 100.0, 30.0, 70.0]

      assert column_heights == expected_column_heights
    end
  end
end
