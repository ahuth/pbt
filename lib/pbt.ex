defmodule Pbt do
  def biggest([head | tail]) do
    biggest(tail, head)
  end

  def biggest([], max), do: max
  def biggest([head|tail], max) when head > max, do: biggest(tail, head)
  def biggest([head|tail], max), do: biggest(tail, max)

  def encode(t), do: :erlang.term_to_binary(t)
  def decode(t), do: :erlang.binary_to_term(t)
end
