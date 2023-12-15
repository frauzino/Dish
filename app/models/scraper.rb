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
end
