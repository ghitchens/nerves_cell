defmodule Nerves.Cell.Mixfile do
  use Mix.Project

  def project do
    [app: :nerves_cell,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application, do: [
    applications: [
      :logger,
      :nerves_firmware,
      :nerves_networking,
      :nerves_ssdp_server
    ],
    mod: {Nerves.Cell, []}
  ]

  defp deps, do: [
    {:nerves_firmware, github: "ghitchens/nerves_firmware"},
    {:nerves_networking, github: "nerves-project/nerves_networking"},
    {:nerves_ssdp_server, github: "nerves-project/nerves_ssdp_server"},
  ]
end