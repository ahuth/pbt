defmodule PbtTest do
  use ExUnit.Case
  use PropCheck

  property "finds biggest element" do
    forall x <- non_empty(list(integer())) do
      Pbt.biggest(x) == model_biggest(x)
    end
  end

  def model_biggest(list) do
    List.last(Enum.sort(list))
  end

  property "picks the last number" do
    forall {list, known_last} <- {list(number()), number()} do
      known_list = list ++ [known_last]
      known_last == List.last(known_list)
    end
  end

  property "a sorted list has ordered pairs" do
    forall list <- list(term()) do
      is_ordered(Enum.sort(list))
    end
  end

  def is_ordered([a, b | tail]) do
    a <= b and is_ordered([b | tail])
  end
  def is_ordered(_), do: true

  property "a sorted list keeps its size" do
    forall list <- list(term()) do
      length(list) === length(Enum.sort(list))
    end
  end

  property "a sorted list has no added elements" do
    forall list <- list(term()) do
      sorted = Enum.sort(list)
      Enum.all?(sorted, fn element -> element in list end)
    end
  end

  property "a sorted list has no missing elements" do
    forall list <- list(term()) do
      sorted = Enum.sort(list)
      Enum.all?(list, fn element -> element in sorted end)
    end
  end

  property "symmetric encoding/decoding" do
    forall data <- list({atom(), any()}) do
      encoded = Pbt.encode(data)
      is_binary(encoded) and data == Pbt.decode(encoded)
    end
  end
end
