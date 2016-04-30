defmodule NervesCell.Mixfile do
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
    pplications: [:logger],
    mod: {NervesCell, []}
  ]

  defp deps, do: [
    {:nerves_networking, github: "nerves_project/nerves_networking"},
    {:nerves_ssdp_server, github: "nerves_project/nerves_ssdp_server"},
    {:nerves_firmware, github: "ghitchens/nerves_firmware"}
  ]

end
