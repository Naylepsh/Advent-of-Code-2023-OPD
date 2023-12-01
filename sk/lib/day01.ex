defmodule Day01 do
  def run1 do
    lines = Input.load("./input/day01.txt")
    solve(lines, &Day01.scan_simple/1, &Day01.parse_simple/1)
  end

  def run2 do
    lines = Input.load("./input/day01.txt")
    solve(lines, &Day01.scan_extended/1, &Day01.parse_extended/1)
  end

  def solve(lines, scan, parse) do
    Enum.sum(
      Enum.map(lines, fn line ->
        Day01.calibration_value(line, scan, parse)
      end)
    )
  end

  def calibration_value(line, scan, parse) do
    results = Enum.map(scan.(line), fn result -> List.first(result) end)
    {a, _} = parse.(List.first(results))
    {b, _} = parse.(List.last(results))

    a * 10 + b
  end

  def scan_simple(line) do
    Regex.scan(~r/\d/, line)
  end

  def parse_simple(x) do
    Integer.parse(x)
  end

  def scan_extended(line) do
    scan_extended(line, [])
  end

  def scan_extended(line, acc) do
    xs = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

    case line do
      "" ->
        Enum.reverse(acc)

      content ->
        head = String.first(content)
        tail = String.slice(content, 1..-1)

        case Integer.parse(head) do
          {value, _} ->
            scan_extended(tail, [[head]] ++ acc)

          _ ->
            case Enum.find(xs, fn x -> String.starts_with?(line, x) end) do
              nil ->
                scan_extended(tail, acc)

              finding ->
                scan_extended(tail, [[finding]] ++ acc)
            end
        end
    end
  end

  def parse_extended(x) do
    case x do
      "one" -> {1, ~c""}
      "two" -> {2, ~c""}
      "three" -> {3, ~c""}
      "four" -> {4, ~c""}
      "five" -> {5, ~c""}
      "six" -> {6, ~c""}
      "seven" -> {7, ~c""}
      "eight" -> {8, ~c""}
      "nine" -> {9, ~c""}
      y -> Integer.parse(y)
    end
  end
end
