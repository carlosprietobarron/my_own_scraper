require 'rubygems'
require 'nokogiri'
#require 'httparty'
require 'open-uri'
require './lib/docto.rb'


#@parse_page ||= Nokogiri::HTML(open("https://www.smashingmagazine.com/"))


class Scraper 
    def initialize
        @host_url="https://www.smashingmagazine.com/"
        @doc=nil
    end

    def get_keywords
        p 'type the keywords for your search separated by whitespace'
        str_input=gets.chomp
        return str_input
    end

    def clear_scr
        system("cls") || system("clear")
    end

    def open_url
        @parse_page ||= Nokogiri::HTML(open(@host_url))
        @doc=Docto.new(@parse_page)
    end

    def scrap_doc
        anchors=@parse_page.css('.article--grid').css('h2 a')
        anchors.each do |liga|
            title = liga.text
            link = liga.attribute('href').text
            @doc.store_item(title,link)
          end
    end

    def scrap_to_screen
        @doc.articles.each {|art| puts art.to_text}
    end
end