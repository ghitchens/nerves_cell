defmodule Nerves.Cell.Test do
  use ExUnit.Case, seed: 0
  doctest Nerves.Cell

  @cell_st "nerves-project-org:service:cell:1"

  test "there is a cell service published" do
    Nerves.Cell.setup
    responses = Nerves.SSDPClient.discover target: @cell_st
    assert is_map(responses)
    # Enum.each responses, fn {urn, params} ->
    #   IO.write "#{urn}\t#{inspect params}\n" 
    # end
  end

end
