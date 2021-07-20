defimpl Charts.StackedBarChart, for: Charts.BaseChart do
  alias Charts.BaseChart
  alias Charts.StackedBarChart.{MultiColumn, Rectangle}
  alias Charts.BarChart.Dataset

  def columns(%BaseChart{dataset: nil}), do: []
  def columns(%BaseChart{dataset: dataset}), do: columns(dataset)
  def columns(%Dataset{data: []}), do: []

  def columns(%Dataset{data: data, axes: %{magnitude_axis: %{max: max}}}) do
    width = 100.0 / Enum.count(data)
    margin = width / 4.0

    data
    |> Enum.with_index()
    |> Enum.map(fn {datum, index} ->
      offset = index * width
      column_height = (Map.values(datum.values) |> Enum.sum()) / max * 100

      %MultiColumn{
        width: width,
        column_height: column_height,
        offset: offset,
        label: datum.name,
        bar_width: width / 2.0,
        bar_offset: offset + margin,
        parts: datum.values
      }
    end)
  end

  def rectangles(chart) do
    chart
    |> columns()
    |> rectangles_from_columns(chart.colors)
  end

  defp rectangles_from_columns([], _colors), do: []

  defp rectangles_from_columns(multi_columns, colors) do
    multi_columns
    |> Enum.flat_map(&(build_rectangles_for_column(&1, colors)))
  end

  defp build_rectangles_for_column(column, colors) do
    column.parts
    |> Enum.reduce([], fn {color, height}, acc ->
      case acc do
        [previous | _rectangles] ->
          new_rectangle = %Rectangle{x_offset: column.bar_offset, y_offset: previous.y_offset - height, fill_color: colors[color], width: column.width, height: height}
          [new_rectangle | acc]
        [] ->
          new_rectangle = %Rectangle{x_offset: column.bar_offset, y_offset: 100, fill_color: colors[color], width: column.width, height: height}
          [new_rectangle]
      end
    end)
  end
end

# <rect x="348" y="289.2857142857143" height="34.71428571428572" width="22"></rect>
