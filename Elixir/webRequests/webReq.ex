
# url = "https://www.google.com"
url = "https://apibay.org/t.php?id=20606556"

System.cmd("curl", [url])
|> elem(0)
|> IO.inspect()
|> String.split("\\r\\n")
|> IO.inspect()
