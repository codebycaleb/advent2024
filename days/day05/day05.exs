input = File.read!("./input.txt")

[ordering_rules, updates] = String.split(input, "\n\n")

rules =
  ordering_rules
  |> String.split("\n")
  |> Enum.map(&String.split(&1, "|"))
  |> Enum.reduce(%{}, fn [key, value], acc ->
    Map.update(acc, key, MapSet.new([value]), &MapSet.put(&1, value))
  end)

{correct, incorrect} =
  updates
  |> String.split("\n")
  |> Enum.map(&String.split(&1, ","))
  |> Enum.map(&Enum.reverse/1)
  |> Enum.split_with(&Day05.is_valid?(&1, MapSet.new(), rules))

part_1 = correct

part_2 =
  incorrect
  |> Enum.map(fn list ->
    Enum.reduce(list, [], fn page, acc -> Day05.insert(acc, page, rules) end)
  end)

[part_1, part_2]
|> Enum.map(fn part ->
  part
  |> Enum.map(fn l -> Enum.at(l, div(length(l), 2)) end)
  |> Enum.map(&String.to_integer/1)
  |> Enum.sum()
end)
|> IO.inspect()

defmodule Day05 do
  def is_valid?([], _, _), do: true

  def is_valid?([h | t], seen, rules),
    do:
      MapSet.subset?(seen, Map.get(rules, h, MapSet.new())) &&
        is_valid?(t, MapSet.put(seen, h), rules)

  def insert(pages, page, rules) do
    befores = Map.get(rules, page, MapSet.new())
    index = Enum.find_index(pages, fn p -> MapSet.member?(befores, p) end)

    case index do
      nil -> pages ++ [page]
      _ -> List.insert_at(pages, index, page)
    end
  end
end
