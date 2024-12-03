input = File.read!("./input.txt")

commands =
  Regex.scan(~r/(don't|do|mul\((\d+),(\d+)\))/, input, capture: :all_but_first)

part_1 =
  commands
  |> Enum.filter(&(length(&1) > 1))
  |> Enum.reduce(0, fn [_, l, r], acc ->
    acc + String.to_integer(l) * String.to_integer(r)
  end)

part_2 =
  commands
  |> Enum.reduce({0, "do"}, fn
    ["don't"], {sum, _} -> {sum, "don't"}
    ["do"], {sum, _} -> {sum, "do"}
    _, {sum, "don't"} -> {sum, "don't"}
    [_, l, r], {sum, "do"} -> {sum + String.to_integer(l) * String.to_integer(r), "do"}
  end)
  |> elem(0)

IO.inspect({part_1, part_2})
