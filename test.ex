defmodule Test do
  def main(n) do
    {:ok, pid} = Agent.start_link(fn -> %{0 => 1, 1 => 1} end)
    fib(n, pid)
    Agent.get(pid, &Map.get(&1, n)) |> IO.inspect()
    Agent.stop(pid)
  end

  def fib(n, pid) do
    cache(n, pid, Agent.get(pid, &Map.get(&1, n)))
  end

  def cache(n, pid, nil) do
    val = fib(n - 2, pid) + fib(n - 1, pid)
    Agent.update(pid, &Map.put(&1, n, val))
    val
  end

  def cache(_n, _pid, val), do: val
end

Test.main(3)
