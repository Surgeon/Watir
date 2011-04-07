# encoding: utf-8
require 'watir'

browser = Watir::IE.new
browser.goto('http://krasnodar.yell.ru/stroitelstvo_i_nedvizhimost/nedvizhimost/zemelnye_uchastki_prodazha_arenda/')
select = browser.div(:class => "content-holder")
l = 1
while links = select.li(:index => l) do
  sleep 2
  links.link(:index => 1).click
  puts "ready"
  puts l
#browser.goto('http://all.yell.ru/transport_i_perevozki/perevozki_arenda/perevozki_smeshannye/page19/')
#browser.send_keys("{BROWSER_BACK}")

if browser.div(:id, "results").exists? then


aFile = File.new("D:\myString_tmp"+ l.to_s() +".csv", "w")
arr = []
i = 0
div2 = browser.div(:id, "results")
while true do

	while true do
		arr[i] = div2.h6(:index => i+1).link(:index => 1)
		if !(arr[i].exists?) then break end
		i = i + 1
	end

	k = 0
	while k < i do
		arr[k].click
		div1 = browser.div(:id, "company-main-info")
		d = 1
		txt = div1.li(:index => d).text
		aFile.write(txt + ";")
		while div1.li(:index => d).exists? do
			if div1.li(:index => d).span(:index => 1).exists? then
				if (div1.li(:index => d).span(:index => 1).text == "Телефон:") then 
					txt = div1.li(:index => d).text
					txt = txt.sub(/Телефон:.*\n(.*)/, '\1')
					aFile.write(txt + ";")
				end
				if (div1.li(:index => d).span(:index => 1).text == "Адрес:") then 
					txt = div1.li(:index => d).text
          txt = txt.sub(/Адрес: (.*)/, '\1')
					aFile.write(txt + "\n")
				end
			end
			d = d + 1
		end

		#browser.link(:text, "назад").click
    browser.send_keys("{BROWSER_BACK}")
    sleep 5
		k = k + 1
	end
	if browser.link(:text => "→").exists? then 
		browser.link(:text => "→").click
	else
		break
	end
end

aFile.close
end
  l = l + 1
end