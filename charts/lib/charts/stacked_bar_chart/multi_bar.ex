defmodule Charts.StackedBarChart.MultiBar do
  @moduledoc """
  A struct representing row-level display properties with multiple datum
  """

  defstruct [:height, :offset, :label, :bar_height, :bar_offset, :bar_width, :fill_color, :parts]

  @type t() :: %__MODULE__{
          height: Float.t(),
          offset: Float.t(),
          label: String.t(),
          bar_height: Float.t(),
          bar_offset: Float.t(),
          bar_width: Float.t(),
          parts: list(Map.t())
        }
end
