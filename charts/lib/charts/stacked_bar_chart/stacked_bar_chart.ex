defprotocol Charts.StackedBarChart do
  @spec rows(Charts.chart() | Charts.BarChart.Dataset.t()) ::
          list(Charts.StackedBarChart.MultiBar.t())
  def rows(chart)

  @spec rectangles(Charts.chart() | Charts.BarChart.Dataset.t()) ::
          list(Charts.StackedColumnChart.Rectangle.t())
  def rectangles(chart)
end
