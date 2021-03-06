# just a naming convention
defmodule Hangman.Game do
  # could have state as a map, but it is open and dynamic. We want fixed set of keys.
  # defstruct, keys and default value. creates a named map with same name as module
  # %Hangman.Game{}, som en struct-urerad map
  defstruct(
    turns_left: 7,
    game_state: :init,
    letters: [],
    used: MapSet.new()
  )

  def new_game() do
    Dictionary.random_word() |> new_game
  end

  def new_game(word) do
    %Hangman.Game{
      letters: word |> String.codepoints()
    }
  end

  def tally(game) do
    %{
      game_state: game.game_state,
      turns_left: game.turns_left,
      letters: game.letters |> reveal_guessed(game.used),
      used: game.used |> MapSet.to_list()
    }
  end

  def make_move(game = %{game_state: state}, _guess) when state in [:won, :lost] do
    game
  end

  def make_move(game, guess) do
    accept_move(game, guess, MapSet.member?(game.used, guess))
  end

  def reveal_word(game = %{game_state: state}) when state in [:won, :lost] do
    game.letters |> Enum.join()
  end

  def reveal_word(_game) do
    "HIDDEN"
  end

  #
  # Bellow is private
  #

  defp accept_move(game, _guess, _alreay_guessed = true) do
    Map.put(game, :game_state, :already_used)
  end

  defp accept_move(game, guess, _alreay_guessed) do
    game
    |> Map.put(:used, MapSet.put(game.used, guess))
    |> score_guess(Enum.member?(game.letters, guess))
  end

  defp score_guess(game, _good_guess = true) do
    new_state =
      game.letters
      |> MapSet.new()
      |> MapSet.subset?(game.used)
      |> maybe_won()

    Map.put(game, :game_state, new_state)
  end

  defp score_guess(game = %{turns_left: turns_left = 1}, _bad_guess = false) do
    %{game | game_state: :lost, turns_left: turns_left - 1}
  end

  defp score_guess(game = %{turns_left: turns_left}, _bad_guess = false) do
    %{game | game_state: :bad_guess, turns_left: turns_left - 1}
  end

  defp maybe_won(true), do: :won
  defp maybe_won(_false), do: :good_guess

  defp reveal_guessed(letters, used) do
    letters
    |> Enum.map(fn letter -> reveal_letter(letter, MapSet.member?(used, letter)) end)
  end

  defp reveal_letter(letter, _in_word = true), do: letter
  defp reveal_letter(_letter, _not_in_used = false), do: "_"
end
