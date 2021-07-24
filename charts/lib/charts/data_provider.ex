defmodule Charts.DataProvider do
  @moduledoc """
  `Charts.DataProvider` is a callback module for use in
  client applications. Implement the callbacks defined here
  in your application to provide the data that drives a chart's
  underlying `Charts.dataset`.

  Let's say we have a list of data we want to render in an
  `Charts.ColumnChart`. We will need to populate the `Charts.ColumnChart`'s
  dataset with a list of data, where each data element is an
  `Charts.BaseDatum`.

  Given data that looks like this:

  ```elixir
  [
    %MyApp.Vehicle{id: "supersonic plane ABC", current_velocity: 12000},
    %MyApp.Vehicle{id: "scooter XYZ", current_velocity: 17},
    %MyApp.Vehicle{id: "super car 123", current_velocity: 220}
  ]
  ```

  We will need to transform this data in a way that an `Charts.ColumnChart` can
  understand. We can manage this by defining our own module that implements
  the `Charts.DataProvider` behaviour. Here is an example of how that might
  look.

  ```elixir
  defmodule MyApp.Vehicles.DataProvider do
    @behaviour Charts.DataProvider
    alias Charts.BaseDatum

    # The `get/0` will be used to bootstrap a dataset from scratch.
    @impl true
    def get do
      MyApp.Persistence.list_vehicles()
      |> Enum.map(&vehicle_to_datum/1)
    end

    # `update/2` can be used to react to real-time changes in your dataset
    @impl true
    def update_chart(chart, updates) do
      %Charts.BaseChart{
        chart |
        dataset: %Charts.ColumnChart.Dataset{
          chart.dataset |
            data: Enum.map(updates, &vehicle_to_datum/1)
        }
      }
    end

    defp vehicle_to_datum(%MyApp.Vehicle{} = vehicle) do
      %BaseDatum{
          name: vehicle.id,
          values: [vehicle.current_velocity],
          fill_color: MyAppWeb.ChartStyles.colors().blue_gradient
        }
    end
  end
  ```

  For further examples, take a look at the `Demo` application examples
  in `Charts`'s Github Repo, [here](https://github.com/spawnfest/livechart/tree/master/demo).
  Relevant examples can be found in `Demo.SystemData.MemoryChart` and `Demo.Examples.Cincy`
  [here](https://github.com/spawnfest/livechart/tree/master/demo/lib/demo/examples).

  You can also look at `DemoWeb.PageLive` where chart's are created and data is piped
  into them in realtime using PubSub and Erlang `:timer.send_interval/3` to update the
  charts on the fly.
  """

  @doc """
  Returns data that can be used in a `Charts.chart()` dataset.
  """
  @callback get() :: term()

  @doc """
  Updates a `Charts.chart`'s dataset.
  """
  @callback update_chart(Charts.chart(), term()) :: Charts.chart()
end
