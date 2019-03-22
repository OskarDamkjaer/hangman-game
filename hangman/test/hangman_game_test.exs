defmodule HangmanTest do
  use ExUnit.Case
  alias Hangman.Game

  def assert_moves(game, moves) do
    Enum.reduce(moves, game, fn {move, wanted_state}, acc_state ->
      new_state = Game.make_move(acc_state, move)
      assert new_state.game_state == wanted_state
      new_state
    end)
  end

  test "game is beatable" do
    moves = [
      {"w", :good_guess},
      {"o", :good_guess},
      {"r", :good_guess},
      {"d", :won}
    ]

    assert_moves(Game.new_game("word"), moves)
  end

  test "game is loseable" do
    moves = [
      {"a", :bad_guess},
      {"b", :bad_guess},
      {"c", :bad_guess},
      {"d", :bad_guess},
      {"e", :bad_guess},
      {"f", :bad_guess},
      {"g", :lost},
    ]

    assert_moves(Game.new_game("xyz"), moves)
  end

  test "state not changed when game won or lost" do
    for state <- [:won, :lost] do
      game = Game.new_game() |> Map.put(:game_state, state)
      assert ^game = Game.make_move(game, "x")
    end
  end

  test "first occurance of letter is not already used" do
    new_game = Game.new_game() |> Game.make_move("x")
    assert new_game.game_state != :already_used
  end

  test "second occurance of letter is already used" do
    moves = [{"x", :good_guess}, {"x", :already_used}]
    assert_moves(Game.new_game("hax"), moves)
  end

  test "good guesses are good" do
    game = Game.new_game("word") |> Game.make_move("w")

    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "bad guess is bad" do
    game = Game.new_game("word") |> Game.make_move("l")

    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

end
