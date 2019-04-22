defmodule Procs do
  def greeter(count) do
    receive do
      {:boom, reason} ->
        exit(reason)

      {:add, n} ->
        greeter(count + n)

      msg ->
        IO.puts("#{msg} #{inspect(count)}")
        greeter(count)
    end
  end
end
