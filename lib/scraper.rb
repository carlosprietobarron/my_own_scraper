require 'rubygems'
require 'nokogiri'
#require 'httparty'
require 'open-uri'


#@parse_page ||= Nokogiri::HTML(open("https://www.smashingmagazine.com/"))


class Scraper 
    def initialize
        @host_url="https://www.smashingmagazine.com/"
        @doc=nil
    end

    def get_keywords
        p 'type the keywords for your search separated by whitespace'
        str_input.gets.chomp
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
        #pending
    end
end