defmodule Nerves.Cell do

  use Application
  require Logger

  @ssdp_fields [
      location: "http://localhost:3000/myservice.json",
      server: "MyServerName",
      "cache-control": "max-age=1800"
  ]

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    children = [
      # Define workers and child supervisors to be supervised
      # worker(Nerves.Cell.Worker, [arg1, arg2, arg3]),
    ]
    opts = [strategy: :one_for_one, name: Nerves.Cell.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @cell_ssdp_st "urn:nerves-project-org:service:cell:1"
  @cell_ssdp_server "Nerves"
  @cell_ssdp_location "/_cell/"

  def setup() do
    Logger.info "setting up cell"
    config = Mix.Project.config
    Nerves.SSDPServer.publish usn(config), @cell_ssdp_st, fields(config)
  end

  defp fields(config) do
    [ "Server":             @cell_ssdp_server,
      "Location":           @cell_ssdp_location,
      "X-Id":               id(),
      "X-Version":          config[:version],
      "X-Platform":         platform(config),
      "X-Creation-Date":    config[:creation_date],
      "X-Firmware-Stream":  config[:firmware_stream],
      "X-Tags":             config[:tags] ]
  end

  defp usn(config) do
    "uuid:#{id}::#{platform(config)}"
  end

  defp platform(config), do: config[:platform] || config[:app]
  defp id, do: "2023F8"

end
