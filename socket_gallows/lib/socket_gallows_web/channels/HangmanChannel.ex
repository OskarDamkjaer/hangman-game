defmodule SocketGallowsWeb.HangmanChannel do
  require Logger
  use Phoenix.Channel

  def join("hangman:game", _, socket) do
    game = Hangman.new_game()
    new_socket = assign(socket, :game, game)
    {:ok, new_socket}
  end

  # so many strings :( 

  def handle_in("tally", _, socket) do
    tally = Hangman.tally(socket.assigns.game)
    push(socket, "tally", tally)
    {:noreply, socket}
  end

  def handle_in("make_move", params, socket) do
    tally = Hangman.make_move(socket.assigns.game, params["guess"])
    push(socket, "tally", tally)
    {:noreply, socket}
  end

  def handle_in(unknown, _, socket) do
    Logger.error("no match for client pushed message #{unknown}")
    {:noreply, socket}
  end
end
