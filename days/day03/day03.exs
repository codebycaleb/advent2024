input = File.read!("./input.txt")

commands_values =
  Regex.scan(~r/(don't|do|mul\((\d+),(\d+)\))/, input, capture: :all_but_first)
  |> Enum.map(fn
    [_, l, r] -> String.to_integer(l) * String.to_integer(r)
    [other] -> other
  end)

part_1 =
  commands_values
  |> Enum.filter(&is_integer/1)
  |> Enum.sum()

part_2 =
  commands_values
  |> Enum.reduce({0, "do"}, fn
    "don't", {sum, _} -> {sum, "don't"}
    "do", {sum, _} -> {sum, "do"}
    _, {sum, "don't"} -> {sum, "don't"}
    x, {sum, "do"} -> {sum + x, "do"}
  end)
  |> elem(0)

IO.inspect({part_1, part_2})
