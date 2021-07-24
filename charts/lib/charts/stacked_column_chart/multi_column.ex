defmodule Charts.StackedColumnChart.MultiColumn do
  @moduledoc """
  A struct representing column-level display properties with multiple datum
  """

  defstruct [:width, :column_height, :offset, :label, :bar_width, :bar_offset, :parts]

  @type t() :: %__MODULE__{
          width: Float.t(),
          column_height: Float.t(),
          offset: Float.t(),
          label: String.t(),
          bar_width: Float.t(),
          bar_offset: Float.t(),
          parts: list(Charts.StackedColumnChart.MultiColumn.t())
        }
end
