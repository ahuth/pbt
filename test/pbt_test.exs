defmodule PbtTest do
  use ExUnit.Case
  use PropCheck

  property "finds biggest element" do
    forall x <- non_empty(list(integer())) do
      Pbt.biggest(x) == List.last(Enum.sort(x))
    end
  end
end
