defmodule GallowsWeb.HangmanView do
  use GallowsWeb, :view

  def show_turns(tally) do
    tally.letters |> Enum.join(" ")
  end

  def game_over?(%{game_state: status}) do
    status in [:won, :lost]
  end

  def new_game_button(conn) do
    button("new game", to: Routes.hangman_path(conn, :create_game))
  end
end
