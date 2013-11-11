module Rubyidescat
  class Client
    BASE_URL = 'http://api.idescat.cat/'

    def request_url
      URI.escape(@request_url)
    end

    def initialize(attributes = {})
      attributes.each do |attr, value|
        self.send("#{attr}=", value)
      end
    end

    def poblacio version, format, operation, params = {} 
      @format = format
      @version = version
      @operation = operation
      @params = params
      @request_url = BASE_URL + 'pob/' + @version + '/' + @operation + '.' + @format
      @request_url += '?' + build_additional_args(@params) unless @params.empty?
      make_call
    end

    private

    def make_call
      response = HTTParty.get self.request_url
      return JSON.parse response.body
    end

    def build_additional_args params
      url_params = 'p='
      params.each do |key, value|
        url_params += key
        url_params += '/'
        if value.kind_of? Array
          url_params += value.join(",") 
        else
          url_params += value
        end
      end
      return url_params
    end

  end
end
