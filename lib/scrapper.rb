require 'open-uri'
require 'Nokogiri'

class Scrapper
    attr_accessor :parse_page

    def initialize
        @parse_page ||= 
        Nokogiri::HTML.parse(
            open(
                'http://store.nike.com/us/en_us/pw/mens-nikeid-lifestyle-shoes/1k9Z7puZoneZoi3', 'User-Agent' => 'firefox'
                )
            )
    end

    def get_names
        names = item_container.css('.product-card__link-overlay').children.map{|name| name.text}.compact
    end
    def get_prices
        prices = item_container.css('.product-card__price').children.map{|price| price.text}.compact
    end

    private
    def item_container
        parse_page.css('.product-grid')
    end

    Scrapper = Scrapper.new
    names = Scrapper.get_names
    prices = Scrapper.get_prices

    (0...prices.size).each do |index|
        puts "--- index: #{index + 1} ---"
        puts "Name: #{names[index]} | Price: #{prices[index]}"
    end
end