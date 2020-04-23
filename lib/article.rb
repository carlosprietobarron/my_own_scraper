# rubocop:disable Style/ClassVars
class Article
  attr_reader :index
  attr_accessor :title
  attr_accessor :url

  @@count ||= 0

  def initialize(title, link)
    @@count += 1
    @index = @@count
    @title = title
    url = 'https://www.smashingmagazine.com' + link
    @url = url
  end

  def to_text
    "#{index}.- title #{title} link: #{url}"
  end

  def to_html
    "<div class=\"article-wrapper\"><a href=\"#{url}\">#{title}</a></div>"
  end
end

# rubocop:enable Style/ClassVars
