defmodule Nerves.Cell do

  use Application
  require Logger

  @ssdp_fields [
      location: "http://localhost:3000/myservice.json",
      server: "MyServerName",
      "cache-control": "max-age=1800"
  ]

  @cell_ssdp_st "urn:nerves-project-org:service:cell:1"
  @cell_ssdp_server "Nerves"
  @cell_ssdp_location "/_cell/"

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

  def setup() do
    Logger.info "setting up cell"
#    Nerves.Networking.setup
#    Nerves.SSDPServer.start
    Nerves.SSDPServer.publish ssdp_usn(), @cell_ssdp_st, ssdp_fields()
  end

  defp ssdp_usn() do
    "uuid:#{boardid}"
  end

  defp boardid,  do: "nerves-2023F8"

  defp cell_id, do: boardid()

  defp ssdp_fields() do
    [
      server:  @cell_ssdp_server,
      location: @cell_ssdp_location,
      cellid: cell_id()
    ]
  end

end
