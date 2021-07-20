defprotocol Charts.StackedBarChart do
  @spec columns(Charts.chart() | Charts.BarChart.Dataset.t()) ::
          list(Charts.StackedBarChart.MultiColumn.t())
  def columns(chart)

  @spec rectangles(Charts.chart() | Charts.ColumnChart.Dataset.t()) ::
          list(Charts.StackedBarChart.Rectangle.t())
  def rectangles(chart)
end
