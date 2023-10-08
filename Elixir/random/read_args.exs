# def main(args \\ []) do
#     # newline = &(&1 <> "\n")
#     list_tostring = fn l -> List.foldl(l, [], fn elem, acc -> acc ++ [to_string elem] end) end
#     args
#     |> parse_args()
#     |> (fn {argv, opts} -> IO.puts(">> #{to_string argv} | #{list_tostring.(opts)}") end).()
#     # |> IO.puts(">>#{&1}")for
#     # |> response()
#     # |> (&(&1 <> "\n")).()
#     # |> IO.puts()
#   end

#   defp parse_args(args) do
#     {parsed, args, _} =
#       # args
#       ["--source-path", "lib", "test/enum_test.exs", "--verbose"]
#       |> OptionParser.parse(switches: [upcase: :boolean])

#     {parsed, args}
#   end

#   defp response({opts, word}) do
#     if opts[:upcase], do: String.upcase(word), else: word
#   end

#   # end
  # def hello do
  #   :world
  # end
IO.puts("hey")
