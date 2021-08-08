defimpl Charts.StackedBarChart, for: Charts.BaseChart do
  alias Charts.BaseChart
  alias Charts.StackedBarChart.MultiBar
  alias Charts.StackedColumnChart.Rectangle
  alias Charts.BarChart.Dataset

  def rows(%BaseChart{dataset: nil}), do: []
  def rows(%BaseChart{dataset: dataset}), do: rows(dataset)
  def rows(%Dataset{data: []}), do: []

  def rows(%Dataset{data: data, axes: %{magnitude_axis: %{max: max}}}) do
    height = 100.0 / Enum.count(data)
    margin = height / 4.0

    data
    |> Enum.with_index()
    |> Enum.map(fn {datum, index} ->
      offset = index * height
      bar_width = (Map.values(datum.values) |> Enum.sum()) / max * 100

      %MultiBar{
        height: height,
        offset: offset,
        bar_width: bar_width,
        label: datum.name,
        bar_height: height / 2.0,
        bar_offset: offset + margin,
        parts: datum.values
      }
    end)
  end

  def rectangles(chart) do
    chart
    |> rows()
    |> rectangles_from_rows()
  end

  defp rectangles_from_rows([]), do: []

  defp rectangles_from_rows(multi_bars) do
    multi_bars
    |> Enum.flat_map(&build_rectangles_for_row(&1))
  end

  defp build_rectangles_for_row(row) do
    row.parts
    |> Enum.reject(fn {_color, width} -> width == 0 end)
    |> Enum.reduce([], fn {color, width}, acc ->
      percentage = width / Enum.sum(Map.values(row.parts)) * 100
      rectangle_width = percentage / 100 * row.bar_width

      case acc do
        [previous | _rectangles] ->
          new_rectangle = %Rectangle{
            x_offset: previous.x_offset + previous.width,
            y_offset: row.bar_offset,
            fill_color: color,
            width: rectangle_width,
            height: row.height,
            label: width
          }

          [new_rectangle | acc]

        [] ->
          new_rectangle = %Rectangle{
            x_offset: 0,
            y_offset: row.bar_offset,
            fill_color: color,
            width: rectangle_width,
            height: row.height,
            label: width
          }

          [new_rectangle]
      end
    end)
  end
end
