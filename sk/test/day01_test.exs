defmodule Day01Test do
  use ExUnit.Case
  doctest Day01

  test "calibrate value using first part" do
    input = ["1abc2", "pqr3stu8vwx", "a1b2c3d4e5f", "treb7uchet"]

    expected = [
      12,
      38,
      15,
      77
    ]

    Enum.each(List.zip([input, expected]), fn {input, expected} ->
      result = Day01.calibration_value(input, &Day01.scan_simple/1, &Day01.parse_simple/1)
      assert result == expected
    end)
  end

  test "calibrate value using second part" do
    input = [
      "two1nine",
      "eightwothree",
      "abcone2threexyz",
      "xtwone3four",
      "4nineeightseven2",
      "zoneight234",
      "7pqrstsixteen",
      "honemkmbfbnlhtbq19twonekbp"
    ]

    expected = [29, 83, 13, 24, 42, 14, 76, 11]

    Enum.each(List.zip([input, expected]), fn {input, expected} ->
      result = Day01.calibration_value(input, &Day01.scan_extended/1, &Day01.parse_extended/1)
      assert result == expected
    end)
  end

  test "first half example" do
    lines = [
      "1abc2",
      "pqr3stu8vwx",
      "a1b2c3d4e5f",
      "treb7uchet"
    ]

    assert Day01.solve(lines, &Day01.scan_extended/1, &Day01.parse_extended/1) == 142
  end
end
