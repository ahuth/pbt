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
    forall {list, known_last} <- {list(number), number()} do
      known_list = list ++ [known_last]
      known_last == List.last(known_list)
    end
  end
end
