import gleam/dict
import gleeunit
import gleeunit/should
import utils

pub fn main() {
  gleeunit.main()
}

pub fn frequencies_test() {
  utils.frequencies([1, 1, 1, 2, 5, 5, 5, 5])
  |> should.equal(dict.from_list([#(1, 3), #(2, 1), #(5, 4)]))
}
