defprotocol Charts.StackedColumnChart do
  @spec columns(Charts.chart() | Charts.BarChart.Dataset.t()) ::
          list(Charts.StackedColumnChart.MultiColumn.t())
  def columns(chart)

  @spec rectangles(Charts.chart() | Charts.ColumnChart.Dataset.t()) ::
          list(Charts.StackedColumnChart.Rectangle.t())
  def rectangles(chart)
end
