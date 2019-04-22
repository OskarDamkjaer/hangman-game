defmodule TextClient.Summary do
  def display(game = %TextClient.State{tally: tally}) do
    IO.puts([
      "\n",
      "word so far: #{tally.letters() |> Enum.join(" ")}\n",
      "#{tally.turns_left} guesses left\n",
      "guessed so far: #{tally.used()}\n"
    ])

    game
  end
end
