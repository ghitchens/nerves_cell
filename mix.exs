defmodule Nerves.Cell.Mixfile do
  use Mix.Project

  @version "0.1.1"

  def project do
    [ app: :nerves_cell,
      name: "nerves_cell",
      version: @version,
      elixir: "~> 1.2",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      package: package(),
      docs: docs() ]
  end

  def application do
    [ applications: [:logger, :nerves_networking, :nerves_firmware_http, :nerves_ssdp_server],
      mod: {Nerves.Cell, []} ]
  end

  defp deps do
    [ {:nerves_firmware_http, github: "nerves-project/nerves_firmware_http"},
      {:nerves_networking, github: "nerves-project/nerves_networking"},
      {:nerves_ssdp_server, github: "nerves-project/nerves_ssdp_server"},
      {:nerves_ssdp_client, github: "nerves-project/nerves_ssdp_client", only: :test} ]
   end

   defp docs do
     [ source_ref: "v#{@version}",
       main: "Nerves.Cell",
       source_url: "https://github.com/nerves-project/nerves_cell",
       extras: [ "README.md", "CHANGELOG.md"] ]
   end


   defp package do
     [ maintainers: ["Garth Hitchens"],
       licenses: ["Apache-2.0"],
       links: %{github: "https://github.com/nerves-project/cell"},
       files: ~w(lib config) ++ ~w(README.md CHANGELOG.md LICENSE mix.exs) ]
   end

end
