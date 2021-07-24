defprotocol Charts.BarChart do
  @spec bars(Charts.chart() | Charts.BarChart.Dataset.t()) ::
          list(Charts.BarChart.Bar.t())
  @doc """
  Returns a list of the `Charts.BarChart.Bar.t()` that should be rendered by the chart display adapter
  """
  def bars(chart)
end
