module Sludge
  class Wallet
    attr_accessor :usdt, :btc, :bch

    def initialize(options = {})
      self.usdt = options[:usdt] || 0
      self.btc = options[:btc] || 0
      self.bch = 0
    end

    def print_log
      puts "wallet usdt #{usdt}, btc #{sprintf('%f', btc)}, bch #{sprintf('%f', bch)}"
    end
  end
end
