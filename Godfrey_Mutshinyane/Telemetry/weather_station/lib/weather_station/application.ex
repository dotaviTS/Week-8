defmodule WeatherStation.Application do
  use Application

  def start(_type, _args) do
    children = [
      # Other children
      {Telemetry, name: WeatherStation.TelemetryHandler}
    ]

    opts = [strategy: :one_for_one, name: WeatherStation.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
