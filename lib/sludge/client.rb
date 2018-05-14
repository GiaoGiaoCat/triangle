module Sludge
  class Client
    def initialize(options = {})
      @url = options['url'] || default_url
    end

    def symbols
      get("/v1/common/symbols")
    end

    def get_market_depth(symbol_pair)
     get("/market/depth?symbol=#{symbol_pair}&type=step0")
   end

    private

      def default_url
        "https://api.huobi.pro"
      end

      def get(path, params = {})
        do_get(path, params)
      end


      def do_get(path, params = {})
        uri = build_url_with_params("GET", path, params)
        response = do_http(uri, Net::HTTP::Get.new(uri.request_uri))
        response.body
      end

      def do_http(uri, request)
        http = set_http_client(uri)
        http.request(request)
      end

      def build_url_with_params(request_method, path, params)
        URI.parse "#{@url}#{path}"
      end

      def set_http_client(uri)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        http
      end

      def headers
        {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Accept-Language': 'zh-CN',
          'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36'
        }
      end
  end
end
