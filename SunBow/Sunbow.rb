# encoding: utf-8
#Parsing of "http://www.sunbow.ru"

require 'watir' #attaching "watir" GEM
require 'win32ole' # attaching "win32ole" library

browser = Watir::IE.new #creating new IE process
browser.goto('http://sunbow.ru/search.php?q=%CB%FB%E6%E8+%7C+%D1%E0%ED%E8') #going to page with search results (changeable)

aFile = File.new("D:\Parsed.csv", "w") #opening file


while true do #cycle for pages in search result
  currentPage = Integer(browser.span(:class => "nav-current-page").text) #finding number of current page
  resDiv = browser.div(:class, "search-page") #locating result DIV
  i = 0
  while true do #going through results
    resTable = resDiv.table(:class => "item-tbl", :index => i+1) #locating TABLE with results
    if !resTable.exists? then break end #checking the end of TABLEs
    resTable.link(:index => 1).click #going on the result page

    #taking information

    propTable = browser.table(:class => "properties") #taking properties table of organization
    if propTable.exists? then #checking existence of upper table
      aFile.write(browser.h1(:index => 1).text + ';') #taking name of organization
      k = 1 #initializing counter for properties
      while propTable.tr(:index => k).exists? #moving through all properties
        current = propTable.tr(:index => k) #taking current <TR> tag
        if current.td(:class => "propname").text == "Адреса" then #checking and taking adress
          txt = current.td(:index => 2).text #taking adress property
          txt = txt.gsub(/.\n/,',') #cleaning text of "\n"
          aFile.write(txt +';') #writing adress in file
        end
        if current.td(:class => "propname").text == "Телефоны" then #checking and taking phone
          txt = current.td(:index => 2).text #taking Phone property
          txt = txt.gsub(/.\n/,',') #cleaning text of "\n"
          aFile.write(txt +';') #writing phone in file
        end
        k = k + 1 #incrementing properties counter
      end
      aFile.write("\n") #going to the new line in file
    end

    browser.send_keys("{BROWSER_BACK}") #sending "Back" to browser
    sleep 5 #freezing for 5 seconds
    if !resDiv.exists? then sleep 10 end #freezing for 10 seconds if suspended
    i = i + 1 #counter incrementation
  end
  nextPage = browser.link(:text => (currentPage+1).to_s) #finding the NEXT page
  if nextPage.exists? then nextPage.click #checking NEXT page existence and going to
  else
   break #finishing last cycle
  end
end
aFile.close #closing file
