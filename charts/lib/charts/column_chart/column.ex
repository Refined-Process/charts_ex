defmodule Charts.ColumnChart.Column do
  @moduledoc """
  A struct representing column-level display properties.
  """

  defstruct [:width, :offset, :label, :column_width, :column_offset, :column_height, :fill_color]

  @type t() :: %__MODULE__{
          width: Float.t(),
          offset: Float.t(),
          label: String.t(),
          column_width: Float.t(),
          column_offset: Float.t(),
          column_height: Float.t(),
          fill_color: atom()
        }
end
