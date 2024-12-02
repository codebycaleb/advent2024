import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import utils

pub fn main() {
  let parsed =
    utils.input("./input.txt")
    |> list.map(fn(line) {
      let ints =
        line |> string.split(" ") |> list.map(int.parse) |> result.all()
      case ints {
        Ok(ints) -> ints
        _ -> panic
      }
    })

  let part_1 =
    parsed
    |> list.filter(fn(l) {
      let diffs = diffs(l)

      let safe = safe_increase(diffs) || safe_decrease(diffs)
      safe
    })
    |> list.length

  let part_2 =
    parsed
    |> list.filter(fn(l) {
      let length = list.length(l)
      let combos =
        list.range(0, length)
        |> list.map(fn(i) {
          list.flatten([list.take(l, i), list.drop(l, i + 1)])
        })
      list.any(combos, fn(c) {
        let diffs = diffs(c)
        safe_increase(diffs) || safe_decrease(diffs)
      })
    })
    |> list.length

  io.debug(#(part_1, part_2))
}

fn diffs(l) {
  list.zip(l, list.drop(l, 1))
  |> list.map(fn(t) { t.0 - t.1 })
}

fn safe_increase(diffs) {
  list.all(diffs, fn(d) { d >= 1 && d <= 3 })
}

fn safe_decrease(diffs) {
  list.all(diffs, fn(d) { d <= -1 && d >= -3 })
}
