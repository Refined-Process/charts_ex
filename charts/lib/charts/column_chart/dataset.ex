defmodule Charts.ColumnChart.Dataset do
  @moduledoc """
  Struct representing a dataset for a basic column chart.
  """
  defstruct [:axes, :data]

  @type t() :: %__MODULE__{
          axes: Charts.BaseAxes.t(),
          data: list(Charts.BaseDatum.t())
        }
end
