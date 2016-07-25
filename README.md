# Nerves.Cell

Network discoverable, manageable, updatable Nerves devices

__Cell__ is an abstraction for a set of functionality that a Nerves device can
implement, the sum of which allows interesting remote management.

## Current Feature Set

The current implementation is very preliminary, and relies on hardcoded ports
and device descriptions, which will be replaced in time as a more fleshed-out
service discovery architecture comes into play.

- LAN Device Annoucment (via SSDP for now, mDNS to follow)
- LAN Service Annoucment (hard coded for now)
- LAN Firmware updates using [nerves_firmware_http](https://github.com/nerves-project/nerves_firmware_http)

For now, the primary objective of this module is to enable discovery,
management and update of devices on a local area network by using the `cell`
[command line tool](https://github.com/nerves-project/nerves_cli_cell).

## Installation & Use

Since the package is not yet available in hex:

  1. Add nerves_cell to your list of dependencies in `mix.exs`:

        def deps do
          [{:nerves_cell, github: "nerves-project/nerves_cell"}]
        end

  2. Ensure nerves_cell is started before your application:

        def application do
          [applications: [:nerves_cell]]
        end
