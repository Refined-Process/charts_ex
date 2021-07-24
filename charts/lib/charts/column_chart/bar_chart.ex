defprotocol Charts.BarChart do
  @spec columns(Charts.chart() | Charts.BarChart.Dataset.t()) ::
          list(Charts.BarChart.Column.t())
  def columns(chart)
end
