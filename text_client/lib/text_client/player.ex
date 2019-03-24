defmodule TextClient.Player do
  alias TextClient.{State, Summary, Prompter, Mover}

  def play(%State{tally: %{game_state: :won}}) do
    "you won!" |> exit_with_message
  end

  def play(%State{tally: %{game_state: :lost}}) do
    "you lost" |> exit_with_message
  end

  def play(game = %State{tally: %{game_state: :init}}) do
    continue(game)
  end

  def play(game = %State{tally: %{game_state: :already_used}}) do
    continue_with_message(game, "already guessed")
  end

  def play(game = %State{tally: %{game_state: :good_guess}}) do
    continue_with_message(game, "good guess!")
  end

  def play(game = %State{tally: %{game_state: :bad_guess}}) do
    continue_with_message(game, "bad guess, u tried!")
  end

  def play(game = %State{}), do: continue(IO.inspect(game))

  def continue_with_message(game = %State{}, message) do
    IO.puts(message)
    continue(game)
  end

  def continue(game = %State{}) do
    game
    |> Summary.display()
    |> Prompter.accept_move()
    |> Mover.make_move()
    |> play()
  end

  defp exit_with_message(message) do
    IO.puts(message)
    exit(:normal)
  end
end
