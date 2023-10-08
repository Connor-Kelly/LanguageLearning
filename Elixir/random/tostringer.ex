list_tostring = fn l -> List.foldl(l, [], fn elem, acc -> acc ++ [to_string elem] end) end

a = [1, 2, 3, "abc"]

list_tostring.(a)
# ["1", "2", "3", "abc"]
