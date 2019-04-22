defmodule Hangman do
  # sets last thing of do as alias to full if no ", is"
  alias Hangman.Game

  # now can write shorthand only Game instead of Hangman.Game
  # def new_game(), do: Game.new_game()
  # defdelegate, looks lika function but is delegeated down
  defdelegate new_game(), to: Game
  defdelegate make_move(game, guess), to: Game
  defdelegate tally(game), to: Game
  defdelegate reveal_word(game), to: Game
end
