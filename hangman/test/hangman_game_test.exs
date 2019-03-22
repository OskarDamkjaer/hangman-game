defmodule HangmanTest do
  use ExUnit.Case
   test "good guesses are good" do
     game =
       Game.new_game("word")
       |> Game.make_move("w")

     assert game.game_state == :good_guess
     assert game.turns_left == 7
   end

   test "game is beatable and good guesses don't loose turns" do
     beat_game =
       Game.new_game("word")
       |> Game.make_move("w")
       |> Game.make_move("o")
       |> Game.make_move("r")
       |> Game.make_move("d")

     assert beat_game.game_state == :won
     assert beat_game.turns_left == 7
   end

   test "bad guess is bad" do
     beat_game =
       Game.new_game("word")
       |> Game.make_move("l")

     assert beat_game.game_state == :bad_guess
     assert beat_game.turns_left == 6
   end

   test "game is loseable" do
     beat_game =
       Game.new_game("xyz")
       |> Game.make_move("a")
       |> Game.make_move("b")
       |> Game.make_move("c")
       |> Game.make_move("d")
       |> Game.make_move("e")
       |> Game.make_move("f")
       |> Game.make_move("g")

     assert beat_game.game_state == :lost
     assert beat_game.turns_left == 0
   end
 end
more lines
     assert game.turns_left == 7
   end

   test "game is beatable and good guesses don't loose turns" do
     beat_game =
       Game.new_game("word")
 11       |> Game.make_move("w")
   end

   test "first occurance of letter is not already used" do
     {game, _} = Game.new_game()
     {new_game, _} = Game.make_move(game, "x")
     assert new_game.game_state != :already_used
   end

   test "second occurance of letter is already used" do
     moves = [{"x", :good_guess},{"x", :already_used}]
     assert_moves(moves, Game.new_game("hax"))
   end

   test "good guesses are good" do
     game =
       Game.new_game("word")
       |> Game.make_move("w")

     assert game.game_state == :good_guess
     assert game.turns_left == 7
   end

   test "game is beatable" do
     moves = [
       {"w", :good_guess},
       {"o", :good_guess},
       {"r", :good_guess},
       {"d", :good_guess},

   test "first occurance of letter is not already used" do

   test "state not changed when game won or lost" do
     for state <- [:won, :lost] do
       game = Game.new_game() |> Map.put(:game_state, state)
       assert {^game, _} = Game.make_move(game, "x")
     end
   end

   test "first occurance of letter is not already used" do
     {new_game, _} = Game.new_game() |> Game.make_move("x")
     assert new_game.game_state != :already_used
   end

   test "second occurance of letter is already used" do
     moves = [{"x", :good_guess}, {"x", :already_used}]
     assert_moves(Game.new_game("hax"), moves)
   end

   test "good guesses are good" do
     {game, _} = Game.new_game("word") |> Game.make_move("w")

     assert game.game_state == :good_guess
     assert game.turns_left == 7
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

   test "bad guess is bad" do
     {game, _} = Game.new_game("word") |> Game.make_move("l")

     assert game.game_state == :bad_guess
     assert game.turns_left == 6
   end

   test "game is loseable" do
     moves = [
       {"a", :bad_guess},
       {"b", :bad_guess},
       {"c", :bad_guess},
       {"d", :bad_guess},
ngman_game_test.exs" 75L, 1839C written
   end

   test "state not changed when game won or lost" do
     for state <- [:won, :lost] do
       game = Game.new_game() |> Map.put(:game_state, state)
       assert {^game, _} = Game.make_move(game, "x")
     end
   end

   test "first occurance of letter is not already used" do
     {new_game, _} = Game.new_game() |> Game.make_move("x")
     assert new_game.game_state != :already_used
   end

   test "second occurance of letter is already used" do
     moves = [{"x", :good_guess}, {"x", :already_used}]
     assert_moves(Game.new_game("hax"), moves)
   end

   test "good guesses are good" do
     {game, _} = Game.new_game("word") |> Game.make_move("w")

     assert game.game_state == :good_guess
     assert game.turns_left == 7
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

   test "bad guess is bad" do
     {game, _} = Game.new_game("word") |> Game.make_move("l")

     assert game.game_state == :bad_guess
     assert game.turns_left == 6
   end

   test "game is loseable" do
     moves = [
       {"a", :bad_guess},
    {"b", :bad_guess},
       {"c", :bad_guess},
   end
   def make_move(game = %{game_state: state}, _guess) when state in [:won, :lost] do
     {game, _} = Game.new_game()
     {new_game, _} = Game.make_move(game, "x")
     assert new_game.game_state != :already_used
   end

   test "second occurance of letter is already used" do
     moves = [{"x", :good_guess},{"x", :already_used}]
     assert_moves(moves, Game.new_game("hax"))
   end

   test "good guesses are good" do
     game =
       Game.new_game("word")
       |> Game.make_move("w")

     assert game.game_state == :good_guess
     assert game.turns_left == 7
   end

   test "game is beatable" do
     moves = [
       {"w", :good_guess},
       {"o", :good_guess},
       {"r", :good_guess},
