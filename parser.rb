# encoding: utf-8
#Univarsal parser
require "rubygems"
require 'watir' #attaching "watir" GEM
require 'win32ole' # attaching "win32ole" library
=begin
conf = File.new('E:\Ruby\config.txt','r')

puts conf.readline
puts conf.readline
=end
browser = Watir::IE.new #creating new IE process

browser.goto('http://kazan.yell.ru/medicina_krasota_zdorove/apteki_i_farmacevtika/apteki/')

regions = browser.div(:class => 'content-holder')

i = 40
while reg = regions.li(:index => i) do
  sleep 2
  name = reg.text
  if name[1] == ' '
    name[0] = ''
    name[0] = ''
  end
  aFile = File.new("E:\Parse files" + '\ ' + name +"csv", "w")
  bFile = File.new("E:\Parse files" + '\add_' + name +"csv", "w")
  reg.link(:index => 1).click
  i += 1
  while true do
    if browser.ul(:class => 'results', :index => 1).exists? then
      results = browser.ul(:class => 'results')
      d = 1
      while results.li(:index => d, :class => 'oneresult').exists? do
        res = results.li(:index => d, :class => 'oneresult')
        res.link(:index => 1).click
          table = Watir::Table.new(browser,'id','company-main-info')
          k = 1
          begin
            if table[k].h1(:index => 1).exists?
              name = table[k].h1(:index => 1).text
              text = name
              text = text + ';'
            #else
              #text = ';'
            end
            if table[k].strong(:index => 1).exists?
              if table[k].strong(:index => 1).text == 'Телефон:'
                #puts table[k].b(:index => 1).text
                text = text + table[k].b(:index => 1).text + ';'
              #else
                #text = text + ';'
              end
              if table[k].strong(:index => 1).text == 'Адрес:'
                #puts table[k].span(:index => 1).text
                text = text + table[k].span(:index => 1).text + ';'
              #else
                #text = text + ';'
              end

              #------------------------------ additional fields
              text1 = ''
              if table[k].strong(:index => 1).text == 'Доп. телефон:'
                #puts table[k].b(:index => 1).text
                text1 = text1 + table[k].b(:index => 1).text + ';'
              #else
                #text1 = text1 + ';'
              end
              if table[k].strong(:index => 1).text == 'Факс:'
                #puts table[k].b(:index => 1).text
                text1 = text1 + table[k].b(:index => 1).text + ';'
              #else
                #text1 = text1 + ';'
              end
              if table[k].strong(:index => 1).text == 'Вебсайт:'
                #puts table[k].span(:index => 1).text
                text1 = text1 + table[k].span(:index => 1).text + ';'
              #else
                #text1 = text1 + ';'
              end
              #------------------------------

            end
            k += 1
          end while k <= table.row_count
          puts text
          aFile.write(text + "\n")
          if browser.div(:id => 'yp-map-image').image(:index => 1).exists?
            img = browser.div(:id => 'yp-map-image').image(:index => 1)
            text1 = text1 + img.src
          end
          puts text1
          bFile.write(name + ';' + text1 + "\n")
        browser.back
        #browser.send_keys("{BACKSPACE}")
        puts ' '
        #sleep 5
        d += 1
      end
    end
    #browser.div(:id => 'show-other').link(:index => 1).click
    if browser.ul(:class => 'results', :index => 2).exists? then
      results = browser.ul(:class => 'results', :index => 2)
      d = 1
      while results.li(:index => d, :class => 'oneresult').exists? do
        res = results.li(:index => d, :class => 'oneresult')
        #puts res.text
        res.link(:index => 1).click
          table = Watir::Table.new(browser,'id','company-main-info')
          k = 1
          begin
            if table[k].h1(:index => 1).exists?
              name = table[k].h1(:index => 1).text
              text = name
              text = text + ';'
            #else
              #text = ';'
            end
            if table[k].strong(:index => 1).exists?
              if table[k].strong(:index => 1).text == 'Телефон:'
                #puts table[k].b(:index => 1).text
                text = text + table[k].b(:index => 1).text + ';'
              #else
                #text = text + ';'
              end
              if table[k].strong(:index => 1).text == 'Адрес:'
                #puts table[k].span(:index => 1).text
                text = text + table[k].span(:index => 1).text + ';'
              #else
                #text = text + ';'
              end

              #------------------------------ additional fields
              text1 = ''
              if table[k].strong(:index => 1).text == 'Доп. телефон:'
                #puts table[k].b(:index => 1).text
                text1 = text1 + table[k].b(:index => 1).text + ';'
              #else
                #text1 = text1 + ';'
              end
              if table[k].strong(:index => 1).text == 'Факс:'
                #puts table[k].b(:index => 1).text
                text1 = text1 + table[k].b(:index => 1).text + ';'
              #else
                #text1 = text1 + ';'
              end
              if table[k].strong(:index => 1).text == 'Вебсайт:'
                #puts table[k].span(:index => 1).text
                text1 = text1 + table[k].span(:index => 1).text + ';'
              #else
                #text1 = text1 + ';'
              end
              #------------------------------

            end
            k += 1
          end while k <= table.row_count
          puts text
          aFile.write(text + "\n")
          if browser.div(:id => 'yp-map-image').image(:index => 1).exists?
            img = browser.div(:id => 'yp-map-image').image(:index => 1)
            text1 = text1 + img.src
          end
          puts text1
          bFile.write(name + ';' + text1 + "\n")
        browser.back
        puts ' '
        #sleep 2
        d += 1
      end
    end
    if browser.link(:text => "→").exists? then
		  browser.link(:text => "→").click
	  else
		  break
	  end
  end
  if browser.ul(:class => 'paging').link(:text => "1").exists? then
    browser.ul(:class => 'paging').link(:text => "1").click
  end
  aFile.close
  bFile.close
end