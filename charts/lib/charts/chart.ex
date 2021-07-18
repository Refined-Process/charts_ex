defprotocol Charts.Chart do
  @doc """
  Takes an `Charts.chart` data structure
  and returns a title for the chart. The title
  can be used for display purposes, and will
  also be used for accessibility in contexts
  such as web-based SVG charts.
  """
  @spec title(Charts.chart()) :: String.t()
  def title(chart)

  @doc """
  Returns a map where the keys are atoms representing color names
  and the values are either Strings representing hex values or
  `Uncharted.Gradient` structs that can be used to style data
  points in your chart with a gradient.

  ## Examples

      Charts.Chart.colors(my_chart)
      %{
        blue: "#6bdee4",
        rose_gradient: %Uncharted.Gradient{
          start_color: "#642B73",
          stop_color: "#C6426E"
        }
      }
  """
  @spec colors(Charts.chart()) :: %{
          Charts.color_name() => String.t() | Charts.Gradient.t()
        }
  def colors(chart)

  @doc """
  Returns a map containing only `Charts.Gradient` colors.
  This can be used in views to draw and configure gradients
  in different contexts.

  ## Examples

        Charts.Chart.colors(my_chart)
        %{
          rose_gradient: %Charts.Gradient{
            start_color: "#642B73",
            stop_color: "#C6426E"
          },
          blue_gradient: %Charts.Gradient{
            start_color: "#36D1DC",
            stop_color: "#5B86E5"
          }
        }
  """
  @spec gradient_colors(Charts.chart()) :: %{Charts.color_name() => Charts.Gradient.t()}
  def gradient_colors(chart)
end
