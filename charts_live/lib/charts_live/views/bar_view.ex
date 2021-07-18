defmodule ChartsLive.BarView do
  @moduledoc """
  View functions for rendering Bar charts
  """

  # TODO: as we add other charts, move shared functions to shared view

  use Phoenix.View,
    root: "lib/charts_live/templates",
    namespace: ChartsLive

  use Phoenix.HTML

  alias Charts.{Chart, Gradient}
  alias Charts.BarChart.Column

  def color_to_fill(colors, name) do
    case Map.get(colors, name) do
      %Gradient{} -> "url(##{Atom.to_string(name)})"
      value -> value
    end
  end

  def svg_id(chart, suffix) do
    base =
      chart
      |> Chart.title()
      |> String.downcase()
      |> String.replace(~r(\s+), "-")

    base <> "-" <> suffix
  end

  @doc """
  The function used to generate Y Axis labels
  """
  def y_axis(chart, grid_lines, offsetter) do
    content = Enum.map(grid_lines, &y_axis_rows(&1, offsetter))

    content_tag(:svg, content,
      id: svg_id(chart, "ylabels"),
      class: "columns__y-labels",
      width: "8%",
      height: "90%",
      y: "0",
      x: "0",
      style: "overflow: visible"
    )
  end

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

  @doc """
  Generates SVG linearGradient definitions
  """
  def color_defs(chart) do
    content = Enum.map(Chart.gradient_colors(chart), &linear_gradient(&1))
    content_tag(:defs, content)
  end

  defp linear_gradient({name, %Charts.Gradient{start_color: start_color, end_color: end_color}}) do
    content_tag(:linearGradient, id: name) do
      [
        content_tag(:stop, "", stop_color: start_color, offset: "0%"),
        content_tag(:stop, "", stop_color: end_color, offset: "100%")
      ]
    end
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

  defp y_axis_rows(grid_line, offsetter) do
    content_tag(:svg, x: "0", y: "#{offsetter.(grid_line)}%", height: "20px", width: "100%") do
      content_tag(:svg, width: "100%", height: "100%") do
        content_tag(:text, grid_line,
          x: "50%",
          y: "50%",
          font_size: "9px",
          alignment_baseline: "middle",
          text_anchor: "middle"
        )
      end
    end
  end
end
