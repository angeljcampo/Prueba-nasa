require "uri"
require "net/http"
require 'json'

key = "DmEd5we3auG6FHp1BbBA11gjippA7MVDgZF4cCmg"
url = URI("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=#{key}")
https = Net::HTTP.new(url.host, url.port)
https.use_ssl = true
request = Net::HTTP::Get.new(url)
request["Cookie"] = "__cfduid=d96807a53a540a2b41f5f2af356796f621616525946"
response = https.request(request)
data = JSON.parse (response.read_body)

photos_totales = []
data1 = data["photos"].length

data1.times do |i|
  photos_totales.push data["photos"][i]["img_src"]
end

html_li = ""
photos_totales.length.times do |i|
  html_li = html_li + "<li><img src=#{photos_totales[i]}></li>" 
end

html_first = '<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>' 

html_second =
"</head>
<body>
<h1> NASA </h1>
  <ul>
    #{html_li}
  </ul>
</body>
</html>"

html_final = html_first + html_second

File.write('index.html', html_final)

