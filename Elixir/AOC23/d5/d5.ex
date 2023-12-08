filepath = "../inputs/d5smol.txt"
filepath = "../inputs/d5full.txt"

defmodule Maps do
  def mapToRangelist(mapString) do
    l = mapString |> String.split("\r\n")
    name = l |> List.first()

    rangelist =
      l
      |> Enum.drop(1)
      |> Enum.map(fn s ->
        s
        |> String.split(" ")
        |> Enum.map(fn x ->
          Integer.parse(x) |> elem(0)
          # |> IO.inspect()
        end)
      end)
  end

  def convert(rangeList, srcObjects) do
    srcObjects
    |> Enum.map(fn so ->
      # so |> IO.inspect()

      Enum.map(rangeList, fn range ->
        # [rl: rangeList, so: so] |> IO.inspect()
        if so >= Enum.at(range, 1) && so < Enum.at(range, 1) + Enum.at(range, 2) do
          [so: so, src: Enum.at(range, 1), dest: Enum.at(range, 0)]
          # |> IO.inspect()
          so - Enum.at(range, 1) + Enum.at(range, 0)
          # |> IO.inspect()
        else
          0
        end
      end)
      |> Enum.filter(fn x -> x != 0 end)
      |> List.first()
      |> then(fn x ->
        if x == nil do
          so
        else
          x
        end
      end)

      # |> IO.inspect()
    end)
  end
end

maps =
  File.read(filepath)
  |> elem(1)
  |> String.split("\r\n\r\n")
  |> IO.inspect()

[
  seeds,
  seedToSoil,
  soilToFertilizer,
  fertilizerToWater,
  waterToLight,
  lightToTemperature,
  temperatureToHumidity,
  humidityToLocation
] =
  maps |> IO.inspect()

seedsInit =
  String.split(seeds, " ")
  |> Enum.drop(1)
  |> Enum.map(fn i -> Integer.parse(i) |> elem(0) end)

# |> IO.inspect()

[si: seedsInit] |> IO.inspect()

seedRange = seedToSoil |> Maps.mapToRangelist() |> IO.inspect()
soilInit = Maps.convert(seedRange, seedsInit) |> IO.inspect()

soilToFertilizer
|> Maps.mapToRangelist()
|> IO.inspect()
|> Maps.convert(soilInit)
|> List.insert_at(-1, 0)
|> IO.inspect()

# IO.puts("\n")

[
  seedToSoil,
  soilToFertilizer,
  fertilizerToWater,
  waterToLight,
  lightToTemperature,
  temperatureToHumidity,
  humidityToLocation
]
|> Enum.reduce(seedsInit, fn map, acc ->
  IO.puts("\n")
  [map: map, acc: acc] |> IO.inspect()
  map |> Maps.mapToRangelist() |> IO.inspect() |> Maps.convert(acc) |> IO.inspect()
end)
# |> List.insert_at(-1, 0)
|> IO.inspect()
|> Enum.min()
|> IO.inspect()
