import gleam/dict
import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import utils

pub fn main() {
  let #(lefts, rights) =
    utils.input("./input.txt")
    |> list.map(fn(x) {
      let ints =
        x
        |> string.split("   ")
        |> list.map(int.parse)
      case ints {
        [Ok(l), Ok(r)] -> #(l, r)
        _ -> panic
      }
    })
    |> list.unzip
  let sorted_left = list.sort(lefts, by: int.compare)
  let sorted_right = list.sort(rights, by: int.compare)
  let part_1 =
    list.zip(sorted_left, sorted_right)
    |> list.map(fn(t) { int.absolute_value(t.0 - t.1) })
    |> int.sum
  let freq_right = utils.frequencies(sorted_right)
  let part_2 =
    sorted_left
    |> list.map(fn(l) {
      freq_right
      |> dict.get(l)
      |> result.try(fn(f) { Ok(f * l) })
      |> result.unwrap(0)
    })
    |> int.sum
  io.debug(#(part_1, part_2))
}
