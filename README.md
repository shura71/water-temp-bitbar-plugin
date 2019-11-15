## Water temperature
Plugin for [BitBar](https://github.com/matryer/bitbar). 
Water temperature in Ukrainian rivers from [meteo.gov.ua](https://meteo.gov.ua).

![BitBar Example showing Water temperature plugin](https://github.com/shura71/water-temp-bitbar-plugin/master/water-temp.png)

### Possible station ids
- 80986 - Dnipro
- 80136 - Desna
- 80295 - Ros'
- 81017 - Dniester
- 78288 - Seversky Donets
- 81348 - Southern Bug
- 42801 - Danube

### How to use
 - Install ruby
 - Install gem [nokogiri](http://www.nokogiri.org/tutorials/installing_nokogiri.html) and [openssl](https://github.com/ruby/openssl)
 - Drop water.30m.rb file into your BitBar plugins folder
 - Make sure it's executable (in Terminal, do chmod +x water.30m.rb)
 - Edit water.30m.rb and change station id for what you needed