defmodule ChartsLive.BarView do
  @moduledoc """
  View functions for rendering Bar charts
  """

  use ChartsLive.ChartBehavior

  alias Charts.Gradient
  alias Charts.BarChart.Column

  @doc """
  The function used to generate X Axis labels
  """
  def x_axis(chart, columns) do
    x_axis_columns = Enum.map(columns, &x_axis_columns(&1))

    content_tag(:svg, x_axis_columns,
      id: svg_id(chart, "xlabels"),
      class: "columns__x-labels",
      width: "90.5%",
      height: "8%",
      y: "92%",
      x: "9.5%"
    )
  end

  defp x_axis_columns(column) do
    content_tag(:svg, x: "#{column.offset}%", y: "0%", height: "100%", width: "#{column.width}%") do
      content_tag(:svg, width: "100%", height: "100%") do
        content_tag(:text, column.label,
          x: "50%",
          y: "50%",
          alignment_baseline: "middle",
          text_anchor: "middle"
        )
      end
    end
  end
end
