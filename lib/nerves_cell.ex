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
      "X-Firmware-Stream":  config[:firmware_stream] ]
     |> field(:"X-Platform", platform(config))
     |> field(:"X-Tags", config[:tags])
     |> field(:"X-Creation-Date", config[:creation_date], &DateTime.to_iso8601/1)
  end

  # if value truthy, add field with value optionally transformed by fn
  @spec field(Keyword.t, atom, term, function) :: Keyword.t
  defp field(fields, key, val, f \\ &(&1)) do
    if (val) do
      Keyword.put fields, key, f.(val)
    else
      fields
    end
  end

  defp platform(config), do: config[:platform] || config[:app]
  defp usn(config), do: "uuid:#{id}::#{platform(config)}"
  defp id, do: "2023F8"

end
