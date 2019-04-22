defmodule TextClient.Prompter do
  alias TextClient.State

  def accept_move(game = %State{}) do
    game
    |> check_input(IO.gets("Your guess: "))
  end

  defp check_input(_game, {:error, reason}) do
    IO.puts("Game ended #{reason}")
    exit(:normal)
  end

  defp check_input(_game, :eof) do
    IO.puts("you gave up?")
    exit(:normal)
  end

  defp check_input(game, input) do
    input = String.trim(input)
    validate(game, input, input =~ ~r/\A[a-z]\z/)
  end

  defp validate(game, input, _valid = true) do
    Map.put(game, :guess, input)
  end

  defp validate(game, _input, _valid = false) do
    IO.puts("please enter a single lowercase letter")
    accept_move(game)
  end
end
