#!/usr/bin/env ruby
require_relative 'lib/sludge'

# CURRENCIES = %w[
#   btc bch eth etc ltc eos xrp omg dash zec ada act btm bts ht trx neo qtum ela ven snt nas hsr elf gnt
# ]

CURRENCIES = %w[
  bch eth etc ltc eos xrp omg dash
]


def initialize_data
  @client = Sludge::Client.new

  file = File.read "symbols.json"
  data = JSON.parse(file)

  @new_symbols = []

  CURRENCIES.each do |currency|
    data["data"].each do |symbol_data|
      @new_symbols << symbol_data if symbol_data["base-currency"] == currency
    end
  end
end


def get_btc_price
  btc_usdt = @client.get_market_depth('btcusdt')
  btc_usdt.asks[0][0].to_f if btc_usdt.status
end

def buy_btc(price)

end

def working
  initialize_data

  # loop do
  #
  # end

  p2 = get_btc_price

  CURRENCIES.each do |currency|
    p1 = @client.get_market_depth("#{currency}usdt").bids[0][0].to_f
    usdt_symbol = @new_symbols.find { |symbol| symbol["base-currency"] == currency && symbol["quote-currency"] == "btc" }
    p3 = ((p1 * 0.998)/(p2/0.998)).round(usdt_symbol["price-precision"])

    p4 = (@client.get_market_depth("#{currency}btc").asks[0][0].to_f * 0.998).round(usdt_symbol["price-precision"])
    puts "#{currency} #{p3}, #{p4}"
  end
end


working
