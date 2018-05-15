module Sludge
  class Response
    attr :res

    def initialize(res)
      @res = JSON.parse(res)
    end

    def status
      res["status"]
    end

    def data
      res["data"]
    end

    def tick
      res["tick"]
    end

    def bids
      tick["bids"]
    end

    def asks
      tick["asks"]
    end
  end
end
