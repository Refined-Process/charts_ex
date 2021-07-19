defprotocol Charts.LineChart do
  @spec points(Charts.chart() | Charts.ColumnChart.Dataset.t()) ::
          list(Charts.LineChart.Point.t())
  def points(chart)

  @spec lines(Charts.chart() | Charts.ColumnChart.Dataset.t()) ::
          list(Charts.LineChart.Line.t())
  def lines(chart)
end
