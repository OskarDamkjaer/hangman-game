defmodule Hangman.Server do
  alias Hangman.Game
  # Basically saying we are a genserver and gives us 9 default callbacks
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, nil)
  end

  # setup state
  def init(_) do
    {:ok, Game.new_game()}
  end

  def handle_call({:make_move, guess}, _from, game) do
    new_state = Game.make_move(game, guess)
    tally = Game.tally(new_state)
    {:reply, tally, new_state}
  end

  def handle_call({:tally}, _from, game) do
    {:reply, Game.tally(game), game}
  end

  def handle_call({:reveal_word}, _from, game) do
    {:reply, Game.reveal_word(game), game}
  end
end
