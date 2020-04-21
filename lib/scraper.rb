require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'
require_relative '../lib/docto.rb'

class Scraper
  def initialize
    @agent = Mechanize.new { |agent| agent.user_agent_alias = 'Mac Safari' }
    @host_url = 'https://www.smashingmagazine.com/articles'
    @doc = nil
    @keys = nil
  end

  def clear_scr
    system('cls') || system('clear')
  end

  def browse_url
    @keys = keywords_get.split(' ')
    page_cnt = 1
    while page_cnt < 20
      final_url = @host_url
      final_url += "/page/#{page_cnt}" unless page_cnt < 2
      html = @agent.get(final_url).body
      @parse_page = Nokogiri::HTML(html)
      @doc = Docto.new(@parse_page) unless page_cnt > 1
      scrap_doc(@keys)
      page_cnt += 1
    end
  end

  def scrap_to_screen
    clear_scr
    @doc.articles.each { |art| puts art.to_text }
  end

  private

  def keywords_get
    p 'type the keywords for your search separated by whitespace'
    p 'press ENTER to finish'
    str_input = gets.chomp
    clear_scr
    p '             Please wait, this can take some seconds'
    str_input
  end

  def validate(title, keys)
    return true if keys.count < 1
    return true if keys.any? { |w| title.include?(w.downcase.capitalize) }

    false
  end

  def scrap_doc(keys = [])
    anchors = @parse_page.css('.article--post').css('h1 a')
    anchors.each do |liga|
      title = liga.text
      link = liga.attribute('href').text
      @doc.store_item(title, link) if validate(title, keys)
    end
  end

end
