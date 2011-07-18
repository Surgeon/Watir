# encoding: utf-8
#Univarsal parser
require "rubygems"
require 'watir' #attaching "watir" GEM
require 'win32ole' # attaching "win32ole" library
sl = 2
=begin
conf = File.new('E:\Ruby\config.txt','r')

puts conf.readline
puts conf.readline
=end
browser = Watir::IE.new #creating new IE process

browser.goto('http://maps.2gis.ru/moscow/')
=begin
cities = browser.div(:id => 'cityblock')
cit = cities.div(:class => 'sub').table(:class => 'cityblock-table')
i = 1
while cit[i].exists? do
  j = 1
  while cit[i].link(:index => j).exists? do
    cit[i].link(:index => j).click
    puts cit[i][j].text
    j += 1
  end
  i += 1
end
=end
sleep sl
#aFile = File.new("E:\Parse files" + '\2gis_1.txt', "w")
rubrics = browser.div(:class => 'rubric-container')
r = 4 #Org catalog level 1
while rubrics.li(:index => r).span(:index => 1) do

  name = rubrics.li(:index => r).span(:index => 1).text.delete '/'
  rubrics.li(:index => r).span(:index => 1).click



  sleep sl
  m = 5 #Org catalog level 2
  while rubrics.div(:class => 'ul1-linkr', :index => m).exists?
    name = rubrics.div(:class => 'ul1-linkr', :index => m).text.delete '/'
    rubrics.div(:class => 'ul1-linkr', :index => m).link(:index => 1).click
    puts name
    aFile = File.new("E:\Parse files" + '\2gis_'+ name +'.txt', "w")
    m += 1
    sleep sl
    delay = 0
    while !browser.div(:id => 'firm-list').exists? #delay check
          puts 'f_delay ' + (delay += 1).to_s
          sleep sl - 1
        end
    b = 1
    begin
      if b != 1
        browser.span(:class => 'click next').click
        sleep sl
      else
        b = 0
      end
      k = 1
      while browser.div(:id => 'firm-list').div(:class => 'item', :index => k).exists?
        while !browser.div(:id => 'firm-list').div(:class => 'item', :index => k).exists? #delay check
          puts 'delay ' + (delay += 1).to_s
          sleep sl - 1
        end
        browser.div(:id => 'firm-list').div(:class => 'item', :index => k).div(:class => 'click').click
        sleep sl - 1.7
        while !browser.div(:id => 'firm-list').div(:class => 'item open').exists? #delay check
          puts 'delay ' + (delay += 1).to_s
          sleep sl - 1
        end
        data = browser.div(:id => 'firm-list').div(:class => 'item open', :index => 1).text
        data = data.delete "­"
        aFile.write(data + "<br>")

        browser.div(:id => 'firm-list').div(:class => 'item open', :index => 1).div(:class => 'click').click
        sleep sl - 1.7
        k += 1
      end
    end while browser.span(:class => 'click next').exists?
    if browser.div(:class => 'sres').span(:index => 1).exists?
      browser.div(:class => 'sres').span(:index => 1).click
      sleep sl
    end
    aFile.close
  end
  browser.span(:class => 'click back').click
  sleep sl
  r += 1
end

