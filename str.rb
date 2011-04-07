# encoding: utf-8
require 'Csv2sql'
txt = "Адрес: Москва, Ордынка Малая улица, д. 19, стр. 1, оф. 410"
puts txt
puts txt.sub(/Адрес: (.*)/, '\1')
Csv2sql.new("D:\myString.csv").to_updates(['Name', 'Phone', 'Address'], :table => 'accounts')
