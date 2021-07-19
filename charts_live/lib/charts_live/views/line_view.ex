defmodule ChartsLive.LineView do
  @moduledoc """
  View functions for rendering Line charts
  """

  use ChartsLive.ChartBehavior

  alias Charts.LineChart.{Line, Point}

  def svg_polyline_points([]), do: ""

  def svg_polyline_points(points) do
    points
    |> Enum.map(fn %Point{x_offset: x, y_offset: y} -> "#{10 * x},#{1000 - 10 * y}" end)
    |> List.insert_at(0, "#{hd(points).x_offset * 10},1000")
    |> List.insert_at(-1, "#{List.last(points).x_offset * 10},1000")
    |> Enum.join(" ")
  end
end
