import gleam/dict
import gleam/list
import gleam/option.{None, Some}
import gleam/string
import simplifile

pub fn input(from filepath: String) {
  case simplifile.read(filepath) {
    Ok(contents) -> string.split(contents, "\n")
    _ -> []
  }
}

pub fn frequencies(xs) {
  list.fold(xs, dict.new(), fn(acc, x) {
    dict.upsert(acc, x, fn(x) {
      case x {
        Some(i) -> i + 1
        None -> 1
      }
    })
  })
}
