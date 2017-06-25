class ContentFromUrlParser

  require 'open-uri'
  attr_reader :page_url

  def initialize(page_url)
    @page_url = page_url
  end

  def contents
    @parsed_content ||= get_content
    {
      error: @parsed_content[:error],
      h1: @parsed_content[:h1s],
      h2: @parsed_content[:h2s],
      h3: @parsed_content[:h3s],
      links: @parsed_content[:links],
      page_url: page_url
    }
  end

  private
  def get_content
    result = ActiveSupport::HashWithIndifferentAccess.new
    doc = scrape_page

    # check error
    if doc == 'error'
      result['error'] = true
      return result
    end

    # get contents of header tags
    ['h1', 'h2', 'h3'].each do |tag|
      result["#{tag}s"] ||= []
      doc.css(tag).each do |div|
        result["#{tag}s"] << div.content
      end
    end
    Nokogiri::HTML::Document
    # get url of links
    result['links'] ||= []
    doc.css('a').each do |a|
      result['links'] << a['href']
    end
    result
  end

  def scrape_page
    @page ||=
      begin
        Nokogiri::HTML(open(page_url))
      rescue
        'error'
      end
  end
end
