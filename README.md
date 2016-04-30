# Nerves.Cell (NOT READY YET)

Network-enabled, discoverable, configurable, updatable devices, manageable by
the `cell` command-line tool, and conforming to the [cell protocol](https://rosepoint.quip.com/aWp1A7ADsnpd).

## Current Feature Set

- Over-network firmware updates (LAN only)
- LAN Device Discovery (via SSDP, for now)
- Service Discovery
- Network configuration

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add nerves_cell to your list of dependencies in `mix.exs`:

        def deps do
          [{:nerves_cell, "~> 0.0.1"}]
        end

  2. Ensure nerves_cell is started before your application:

        def application do
          [applications: [:nerves_cell]]
        end

## Roadmap

- WAN Discovery and firewall traversal
