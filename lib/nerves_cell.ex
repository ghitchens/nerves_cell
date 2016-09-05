defmodule Nerves.Cell do

  use Application
  require Logger

  @project Mix.Project.config

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
    config = Application.get_all_env(:nerves_cell)
    Logger.info "setting up cell"
    Nerves.SSDPServer.publish usn(config), @cell_ssdp_st, fields(config)
  end

  defp fields(config) do
    [ "Server":             @cell_ssdp_server,
      "Location":           @cell_ssdp_location,
      "X-Id":               board_id() || "unknown",
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
  defp usn(config), do: "uuid:#{board_id() || "unknown"}::#{platform(config)}"

  # return a board ID, or :unknown if the board ID cannot be generated
  # REVIEW TODO cache in ets, move to library, handle other board types better
  defp board_id do
    try do
      {raw_id, 0} = System.cmd "boardid", ["-n", "6"]
      String.strip(raw_id)
    rescue
      _ in ErlangError -> nil
    end
  end

end