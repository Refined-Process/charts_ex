defmodule Charts.LineChart.Line do
  @moduledoc """
  A struct representing a Line on a cartesian plane betwen two `Charts.LineChart.Point` structs
  """

  alias Charts.LineChart.Point

  defstruct [:start, :end]

  @type t() :: %__MODULE__{
          start: Point.t(),
          end: Point.t()
        }
end
