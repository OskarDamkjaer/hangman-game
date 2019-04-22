defmodule TextClient.Mover do
  alias TextClient.State

  def make_move(game) do
    Hangman.make_move(game.game_service, game.guess)
    pid = game.game_service

    %State{
      game_service: pid,
      tally: Hangman.tally(pid),
      guess: "",
      word: Hangman.reveal_word(pid)
    }
  end
end
