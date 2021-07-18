defmodule Charts.Gradient do
  @moduledoc """
  Defines the a gradients start and end colors
  """

  @type t() :: %__MODULE__{
          start_color: String.t(),
          end_color: String.t()
        }

  defstruct [:start_color, :end_color]
end
