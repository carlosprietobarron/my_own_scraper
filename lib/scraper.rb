require 'rubygems'
require 'nokogiri'
#require 'httparty'
require 'open-uri'
require './lib/docto.rb'
require "mechanize"


#@parse_page ||= Nokogiri::HTML(open("https://www.smashingmagazine.com/"))


class Scraper 
    def initialize
        @agent = Mechanize.new { |agent| agent.user_agent_alias = "Mac Safari" }
        @host_url="https://www.smashingmagazine.com/articles"
        @doc=nil
        @keys=nil
    end

    def get_keywords
        p 'type the keywords for your search separated by whitespace'
        str_input=gets.chomp
        return str_input
    end

    def clear_scr
        system("cls") || system("clear")
    end

    def browse_url
        #@keys=get_keywords
        @keys=get_keywords.split(" ")
        i=0
        while i<@keys.count
            puts @keys[i]
            puts "#{i}\n"
            i+=1
        end
        p "keys #{@keys.inspect}"
        page_cnt=1
        while page_cnt<20 
            finalUrl=@host_url
            finalUrl=finalUrl+"/page/#{page_cnt.to_s}" unless page_cnt<2
            # p finalUrl
            # gets
            html = @agent.get(finalUrl).body
            @parse_page = Nokogiri::HTML(html)
            @doc=Docto.new(@parse_page) unless page_cnt > 1
            scrap_doc(@keys)
            page_cnt += 1
        end
    end

    def validate(title,keys)
     return true if keys.count<1
     return true if keys.any? {|w|title.include?(w.downcase.capitalize)}
     false
    end

    def scrap_doc(keys=[])
        anchors=@parse_page.css('.article--post').css('h1 a')
        anchors.each do |liga|
            title = liga.text
            link = liga.attribute('href').text
            @doc.store_item(title,link) if validate(title,keys)
          end
    end

    # def scrap_doc
    #     anchors=@parse_page.css('.article--grid').css('h2 a')
    #     anchors.each do |liga|
    #         title = liga.text
    #         link = liga.attribute('href').text
    #         @doc.store_item(title,link)
    #       end
    # end

    def scrap_to_screen
        @doc.articles.each {|art| puts art.to_text}
    end
end