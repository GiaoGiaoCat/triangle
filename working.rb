#!/usr/bin/env ruby
require_relative 'lib/sludge'

SYMBOLS = %w[
  btc bch eth etc ltc eos xrp omg dash zec ada act btm bts ht trx neo qtum ela ven snt nas hsr elf gnt
]

# client = Sludge::Client.new
# p client.symbols

file = File.read "symbols.json"
data = JSON.parse(file)

new_symbols = []

SYMBOLS.each do |symbol|
  data["data"].each do |symbol_data|
    new_symbols << symbol_data if symbol_data["base-currency"] == symbol
  end
end

puts new_symbols

# 先拿 BTC 当前买1价
