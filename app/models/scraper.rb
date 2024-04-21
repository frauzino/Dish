class Scraper < ApplicationRecord

  def school_scraper
    url = 'https://www.4icu.org/us/a-z/'

    html_file = URI.open(url).read
    html_doc = Nokogiri::HTML.parse(html_file)
    schools_array = []

    html_doc.search('tr')[2..-2].each do |element|
      schools_array << element.children[3].children.text
    end
    return schools_array
  end

  def state_scraper
    url = 'https://www23.statcan.gc.ca/imdb/p3VD.pl?Function=getVD&TVD=53971'

    html_file = URI.open(url).read
    html_doc = Nokogiri::HTML.parse(html_file)
    states_array = []

    html_doc.search('tr')[1..].each do |element|
      states_array << element.children[7].text
    end
    return states_array
  end
end
