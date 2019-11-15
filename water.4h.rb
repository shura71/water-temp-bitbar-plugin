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

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
STATION_ID = '80986'

doc = Nokogiri::XML(open('https://meteo.gov.ua/kml/kml_hydro_warn.kml'))
begin
  kyiv = doc.css('Placemark').reject {|p| p.css('name').text != STATION_ID }.map {|p| p.css('description').text }
  text = kyiv[0].gsub(/(<b>|<\/b>)/,'').gsub(/<br>/,"\n").gsub(/\t/,'').gsub(/^\s+/,'').gsub(/<!--([^>]+)-->/,'').gsub(/\n\n\n/,'')
  lines = ['---']
  text.split(/\n/).each do |line|
    next if /(Область)/u =~ line
    lines.unshift("〰️ #{$1}℃") and next if /Температура води (\d+)/u =~ line
    lines << line
  end
  lines << '---'
  lines << 'Укргiдрометцентр | href=https://meteo.gov.ua/ua/33345/hydrology/hydr_water_level_changes_map/'
  puts lines.join("\n")
rescue
  puts "Немає даних постів спостережень!"
end
