# Nerves.Cell

Network discoverability, updatability, and metadata for devices

__Cell__ is an abstraction for a set of functionality that a Nerves device can
implement, the sum of which allows interesting remote management features.

## Current Feature Set

The current implementation is very preliminary, and relies on hardcoded ports
and device descriptions, which will be replaced in time as a more fleshed-out
service discovery architecture comes into play.

- LAN Device Announcement (via SSDP for now, mDNS to follow)
- LAN Service Announcement (hard coded for now)
- LAN Firmware updates using [nerves_firmware_http](https://github.com/nerves-project/nerves_firmware_http)

For now, the primary objective of this module is to enable discovery,
management and update of devices on a local area network by using the `cell`
[command line tool](https://github.com/nerves-project/cell-tool/).

## Installation & Use

Since the package is not yet available in hex, add `nerves_cell` to your dependencies in `mix.exs`:

```elixir
def deps do
  [{:nerves_cell, github: "ghitchens/nerves_cell"}]
end
```

Then somewhere in your application when you know that networking is available, start `nerves_cell` up by calling:

```elixir
Nerves.Cell.setup()
```

