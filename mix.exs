defmodule Nerves.Cell.Mixfile do

  use Mix.Project

  @version "0.2.1-dev"

  def project do
    [ app: :nerves_cell,
      name: "nerves_cell",
      version: @version,
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      package: package(),
      docs: docs() ]
  end

  def application do
    [ applications: [:logger, :nerves_firmware_http, :nerves_ssdp_server],
      mod: {Nerves.Cell, []} ]
  end

  defp deps do
    [ {:nerves_firmware_http, github: "nerves-project/nerves_firmware_http"},
      {:nerves_ssdp_server, ">= 0.0.1"},
      {:nerves_ssdp_client, ">= 0.0.1", only: :test} ]
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
       links: %{github: "https://github.com/nerves-project/nerves_cell"},
       files: ~w(lib config) ++ ~w(README.md CHANGELOG.md LICENSE mix.exs) ]
   end
end
