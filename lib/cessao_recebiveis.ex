defmodule CessaoRecebiveis do
  @moduledoc false

  def generate_random do
    Enum.map(1..1000, fn _ -> {Enum.random(50..700), Enum.random(1..12)} end)
    ++ Enum.map(1..8000, fn _ -> {Enum.random(701..2000), Enum.random(1..12)} end)
    ++ Enum.map(1..1000, fn _ -> {Enum.random(2001..10_000), Enum.random(1..12)} end)
  end

  def calculate_minimum_loss(numbers) do
    numbers
    |> Enum.map(fn {value, quoc} -> %{value: value / quoc, loss: get_loss(quoc)} end)
    |> Enum.sort(fn %{loss: loss1}, %{loss: loss2} -> loss1 <= loss2 end)
    |> IO.inspect
    |> Enum.reduce_while(%{values: [], sum: 0.0}, &collect/2)
  end

  def collect(%{value: value} = current, %{values: values, sum: sum} = acc) do
    if sum < 700_000 do
      {:cont, %{values: values ++ [current], sum: sum + value}}
    else
      {:halt, acc}
    end
  end

  @loss_table %{
    1 => 0.1,
    2 => 0.08,
    3 => 0.06,
    4 => 0.04,
    5 => 0.03,
    6 => 0.02,
    7 => 0.01,
    8 => 0.01,
    9 => 0.01,
    10 => 0.01,
    11 => 0.01,
    12 => 0.01,
  }

  defp get_loss(quoc), do: @loss_table[quoc]

end
