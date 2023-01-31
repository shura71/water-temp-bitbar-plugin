#!/usr/bin/env ruby -W0
# <bitbar.title>Water temperature in Ukrainian rivers</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Shura Scherban</bitbar.author>
# <bitbar.author.github>shura71</bitbar.author.github>
# <bitbar.desc>Water temperature in Ukrainian rivers from meteo.gov.ua</bitbar.desc>
# <bitbar.image>https://raw.github.com/shura71/water-temp-bitbar-plugin/master/water-temp.png</bitbar.image>
# <bitbar.dependencies>ruby</bitbar.dependencies>
# <bitbar.abouturl>https://github.com/shura71/water-temp-bitbar-plugin</bitbar.abouturl>
# encoding: utf-8
require 'nokogiri'
require 'openssl'
require 'open-uri'
require 'json'

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
STATION_ID = '80986'

begin
  stations = JSON.parse(open('https://www.meteo.gov.ua/ua/_hydro-posts.js').read.gsub(/const HYDRO_POSTS = /,'').gsub(/;$/,''))
  station = stations[STATION_ID]
  
  data = JSON.parse(open("https://www.meteo.gov.ua/_/m/hydroday.js?4#{Date.today.strftime("%Y-%m-%d-%H-%M")}").read)[STATION_ID]
  
  lines = ['---']
  
  lines.unshift("〰️ #{data['TW']}℃")
  lines << "Пост: #{station['P']}"
  lines << "Рiчка: #{station['R']}"
  lines << "Фактичний рівень води: #{data['FR']}см. (#{data['FR_BS']} м БС)"
  lines << "Рівень за останню добу: #{data['C_FR'] > 0 ? "збiльшився на #{data['C_FR'].abs} м" : (data['C_FR'] < 0 ? "зменшився на #{data['C_FR'].abs} м" : 'без змiн')}"
  lines << "Дані на #{data['PD']}"
  lines << '---'
  lines << 'Укргiдрометцентр | href=https://meteo.gov.ua/ua/33345/hydrology/hydr_water_level_changes_map/'
  puts lines.join("\n")
rescue
  puts "Немає даних постів спостережень!"
end

puts "---"
puts "Оновити | refresh=true"
puts "Налаштування"
puts "-- Відредагуйте плагін безпосередньо, щоб:"
puts "-- • Змiнити водойму"
puts "-----"
