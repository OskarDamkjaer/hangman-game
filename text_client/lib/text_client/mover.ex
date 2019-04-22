defmodule TextClient.Mover do
  alias TextClient.State

  def make_move(game) do
    new_game = Hangman.make_move(game.game_service, game.guess)

    %State{
      game_service: new_game,
      tally: Hangman.tally(new_game),
      guess: "",
      word: Hangman.reveal_word(new_game)
    }
  end
end
