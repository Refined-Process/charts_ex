defmodule Charts.BarChart.Dataset do
  @moduledoc """
  Struct representing a dataset for a Charts basic bar chart.
  """
  defstruct [:axes, :data]

  @type t() :: %__MODULE__{
          axes: Charts.BaseAxes.t(),
          data: list(Charts.BaseDatum.t())
        }
end
