defmodule GallowsWeb.HangmanController do
  use GallowsWeb, :controller

  def new_game(conn, _params) do
    render(conn, "new_game.html")
  end

  def make_move(conn, params) do
    guess = params["make_move"]["guess"]

    tally =
      conn
      |> get_session(:game)
      |> Hangman.make_move(guess)

    conn.params["make_move"]["guess"]
    |> put_in("")
    |> render("game_field.html", tally: tally)
  end

  def create_game(conn, _params) do
    game = Hangman.new_game()
    tally = Hangman.tally(game)
    # sessions, enklaste är cookies. 5/10. blir lätt klydd
    conn
    |> put_session(:game, game)
    |> render("game_field.html", tally: tally)
  end
end
