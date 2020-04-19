require './lib/scraper.rb'

scrap=Scraper.new
scrap.clear_scr
keys=scrap.get_keywords
scrap.open_url
scrap.scrap_doc
scrap.scrap_to_screen
