defprotocol Charts.ColumnChart do
  @spec columns(Charts.chart() | Charts.ColumnChart.Dataset.t()) ::
          list(Charts.ColumnChart.Column.t())
  def columns(chart)
end
