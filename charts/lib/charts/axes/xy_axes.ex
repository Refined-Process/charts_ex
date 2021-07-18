defmodule Charts.Axes.XYAxes do
  @moduledoc """
  A struct for representing a cartesian plane's axes
  """

  defstruct [:x, :y, show_gridlines: true]

  @type t() :: %__MODULE__{
          x: Charts.Axes.MagnitudeAxis.t(),
          y: Charts.Axes.MagnitudeAxis.t(),
          show_gridlines: boolean()
        }
end
