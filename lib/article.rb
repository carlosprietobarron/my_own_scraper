class Article
    attr_reader :index
    attr_accessor :title
    attr_accessor :url

    @@count ||=0

    def initialize(title,url)
        count+=1
        @index=count
        @title=title
        @url=url
    end

    def to_text
        return "url"
    end
end