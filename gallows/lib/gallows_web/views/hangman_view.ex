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

  def turn(left, target) when target >= left do
    "opacity: 1"
  end

  def turn(left, target) do
    "opacity: 0.1"
  end
end
