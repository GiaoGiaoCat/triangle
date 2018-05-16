#!/usr/bin/env ruby
require_relative 'lib/sludge'


def initialize_data
  @client = Sludge::Client.new
  @wallet = Sludge::Wallet.new(usdt: 1000)

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
  @wallet.buy("usdt", "btc", price)
  @wallet.print_log
end

def buy_bch(price)
  amount = (@wallet.btc / price).floor(BCH_BTC_AMOUNT_PRECISION)
  @wallet.btc -= (amount * price)
  @wallet.bch = amount * 0.998
  @wallet.print_log
end

def sell_bch(price)
  amount = (@wallet.bch * price).floor(BCH_USDT_AMOUNT_PRECISION)
  @wallet.usdt += (amount * 0.998)
  @wallet.bch -= @wallet.bch.floor(BCH_USDT_PRICE_PRECISION)
  @wallet.print_log
end


def straddle_strike(p1, p2, p3)
  buy_btc(p1)
  buy_bch(p3)
  sell_bch(p2)
end

def working
  initialize_data

  p1 = get_btc_price

  CURRENCIES.each do |currency|
    p2 = @client.get_market_depth("#{currency}usdt").bids[0][0].to_f
    usdt_symbol = @new_symbols.find { |symbol| symbol["base-currency"] == currency && symbol["quote-currency"] == "btc" }
    p3 = @client.get_market_depth("#{currency}btc").asks[0][0].to_f

    left_condition = ((p2 * 0.998)/(p1/0.998)).floor(usdt_symbol["price-precision"])
    right_condition = (p3 / 0.998).floor(usdt_symbol["price-precision"])

    puts "#{currency}, p1 #{p1}, p2 #{p2}, p3 #{sprintf('%f', p3)}, left_condition #{sprintf('%f', left_condition)}, right_condition #{sprintf('%f', right_condition)}"

    # 满足条件进行套利测试
    straddle_strike(p1, p2, p3)
    # margin_straddle(p1, p2, p3)
  end
end


working
