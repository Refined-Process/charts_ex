defmodule Charts.StackedBarChart.Rectangle do
  @moduledoc """
  A struct representing a Rectangle on an x, y coordinate chart
  """

  defstruct [:fill_color, :x_offset, :y_offset, :width, :height]

  @type t :: %__MODULE__{
          fill_color: atom(),
          x_offset: Float.t(),
          y_offset: Float.t(),
          width: Float.t(),
          height: Float.t()
        }
end
