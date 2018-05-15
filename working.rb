#!/usr/bin/env ruby
require_relative 'lib/sludge'

# SYMBOLS = %w[
#   btc bch eth etc ltc eos xrp omg dash zec ada act btm bts ht trx neo qtum ela ven snt nas hsr elf gnt
# ]

SYMBOLS = %w[
  bch
]

client = Sludge::Client.new
# p client.symbols

file = File.read "symbols.json"
data = JSON.parse(file)

new_symbols = []

SYMBOLS.each do |symbol|
  data["data"].each do |symbol_data|
    new_symbols << symbol_data if symbol_data["base-currency"] == symbol
  end
end

# puts new_symbols
btc_usdt = client.get_market_depth('btcusdt')
if btc_usdt.status
  p2 = btc_usdt.asks[0][0].to_f
end

SYMBOLS.each do |symbol|
  p1 = client.get_market_depth("#{symbol}usdt").bids[0][0].to_f
  p p1
  p3 = p1/p2
  p p3
  p4 = client.get_market_depth("#{symbol}btc").asks[0][0].to_f
  p p4
  sleep 5
end
