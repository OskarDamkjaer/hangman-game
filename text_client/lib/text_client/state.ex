defmodule TextClient.State do
  defstruct(
    game_service: nil,
    tally: nil,
    guess: "",
    word: ""
  )
end
