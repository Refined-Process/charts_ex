defmodule Charts.StackedColumnChart.MultiColumn do
  @moduledoc """
  A struct representing column-level display properties with multiple datum
  """

  defstruct [:width, :column_height, :offset, :label, :column_width, :column_offset, :parts]

  @type t() :: %__MODULE__{
          width: Float.t(),
          column_height: Float.t(),
          offset: Float.t(),
          label: String.t(),
          column_width: Float.t(),
          column_offset: Float.t(),
          parts: list(Map.t())
        }
end
