defmodule Cubes do
  defstruct red: 0, green: 0, blue: 0

  def add({v, :red}, cubes), do: %{cubes | red: cubes.red + v}
  def add({v, :green}, cubes), do: %{cubes | green: cubes.green + v}
  def add({v, :blue}, cubes), do: %{cubes | blue: cubes.blue + v}

  def is_possible(cubes, max_cubes) do
    cubes.red <= max_cubes.red and cubes.green <= max_cubes.green and cubes.blue <= max_cubes.blue
  end

  def are_possible(cubess, max_cubes),
    do: Enum.all?(cubess, fn cubes -> is_possible(cubes, max_cubes) end)

  def from_raw_str(str), do: List.foldl(str, %Cubes{}, &add/2)
end

defmodule Day02 do
  def run1 do
    "./input/day02.txt"
    |> Input.load()
    |> solve()
  end

  def solve(lines) do
    lines
    |> Enum.map(&parse/1)
    |> Enum.with_index()
    |> Enum.filter(fn {results, _} ->
      Cubes.are_possible(results, %Cubes{red: 12, green: 13, blue: 14})
    end)
    |> Enum.map(fn {_, index} -> index + 1 end)
    |> Enum.sum()
  end

  def parse(line) do
    [_, raw_results] = String.split(line, ": ")

    raw_results
    |> String.split("; ")
    |> Enum.map(fn raw_result ->
      Regex.scan(~r/(\d+ (blue|red|green))/, raw_result)
      |> Enum.map(fn results ->
        [val, color] = results |> List.first() |> String.split(" ")
        {int, _} = Integer.parse(val)
        {int, parse_color(color)}
      end)
      |> Cubes.from_raw_str()
    end)
  end

  defp parse_color("red"), do: :red
  defp parse_color("green"), do: :green
  defp parse_color("blue"), do: :blue
end
