module Sludge
  class Wallet
    attr_accessor :usdt, :btc, :bch

    def initialize(options = {})
      self.usdt = options[:usdt]
      self.btc = 0
      self.bch = 0
    end

    def buy(currency, symbol, price)
      amount = (1000 / price).floor(BTC_USDT_AMOUNT_PRECISION)
      @wallet.usdt -= (amount * price)
      @wallet.btc = amount * 0.998
    end

    def print_log
      puts "wallet usdt #{usdt}, btc #{sprintf('%f', btc)}, bch #{sprintf('%f', bch)}"
    end
  end
end
