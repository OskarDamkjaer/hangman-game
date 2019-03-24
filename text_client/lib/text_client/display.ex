defmodule TextClient.Summary do
  def display(game = %TextClient.State{tally: tally}) do
    IO.puts([
      "\n",
      "word so far: #{tally.letters() |> Enum.join(" ")}\n",
      "Guesses so far: #{tally.turns_left}\n"
    ])

    game
  end
end
