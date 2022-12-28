import sqlight
import gleeunit
import gleeunit/should
import gleam/list

pub fn main() {
  gleeunit.main()
}

/// All valid SQLite error codes.
const codes = [
  4, 23, 5, 14, 19, 11, 101, 16, 1, 24, 13, 2, 9, 10, 6, 20, 21, 22, 7, 26, 12,
  27, 0, 3, 15, 25, 8, 100, 17, 18, 28, 516, 279, 261, 517, 773, 1038, 1294, 782,
  526, 270, 1550, 275, 531, 3091, 787, 1043, 1299, 2835, 1555, 2579, 1811, 2067,
  2323, 779, 523, 267, 257, 513, 769, 3338, 7178, 7434, 2826, 3594, 4106, 7690,
  6666, 8458, 8202, 2570, 5898, 4362, 1290, 1802, 1034, 6410, 3850, 6154, 3082,
  2314,
]

pub fn errorcode_roundtrip_test() {
  use code <- list.each(codes)
  code
  |> sqlight.code_to_error
  |> sqlight.error_to_code
  |> should.equal(code)
}

pub fn open_test() {
  assert Ok(conn) = sqlight.open("file:open_test?mode=memory")
  assert Ok(Nil) = sqlight.close(conn)
}

pub fn open_fail_test() {
  assert Error(sqlight.GenericError) =
    sqlight.open("file:open_fail_test?mode=wibble")
}