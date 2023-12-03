defmodule Day03 do
  def run1 do
    "./input/day03.txt"
    |> Input.load()
    |> solve()
  end

  def solve(lines) do
    symbols_coords = get_symbol_coords(lines)
    numbers_coords = get_number_coords(lines)

    numbers_coords
    |> Enum.filter(fn number_coords -> adjacent?(number_coords, symbols_coords) end)
    |> Enum.map(fn {value, _, _} -> value end)
    |> Enum.sum()
  end

  defp get_symbol_columns(line) do
    line
    # This will add "" at both start and end of char array
    |> String.split("")
    |> Enum.with_index()
    |> Enum.filter(fn {char, _} ->
      Enum.member?(["$", "#", "*", "+", "-", "@", "=", "%", "/", "&"], char)
    end)
    # Handle the offset caused by additional empty chars
    |> Enum.map(fn {char, idx} -> {char, idx - 1} end)
  end

  def get_symbol_coords(lines) do
    lines
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, row} ->
      line
      |> get_symbol_columns()
      |> Enum.map(fn {char, column} -> {char, row, column} end)
    end)
  end

  def get_number_columns(line) do
    Regex.scan(~r/\d+/, line, return: :index)
    |> Enum.flat_map(fn matches ->
      Enum.map(matches, fn {start, length} ->
        end_pos = start + length - 1
        number = String.slice(line, start..end_pos) |> String.to_integer()
        {number, start, end_pos}
      end)
    end)
  end

  def get_number_coords(lines) do
    lines
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, row} ->
      line
      |> get_number_columns()
      |> Enum.map(fn {number, start, end_pos} ->
        {number, {row, start}, {row, end_pos}}
      end)
    end)
  end

  def adjacent?(_, []), do: false

  def adjacent?(number_coords, [{_, symbol_row, symbol_column} | tail]) do
    {_, {row, start}, {_, end_pos}} = number_coords

    cond do
      row - 1 <= symbol_row and
        symbol_row <= row + 1 and
        start - 1 <= symbol_column and
          symbol_column <= end_pos + 1 ->
        true

      true ->
        adjacent?(number_coords, tail)
    end
  end
end
