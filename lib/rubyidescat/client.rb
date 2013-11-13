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

    def poblacio(version, format, operation, params = {})
      @format = format
      @version = version
      @operation = operation
      @params = params
      @request_url = BASE_URL + 'pob/' + @version + '/' + @operation + '.' + @format
      @request_url += '?p=' + @params.map{|k,v|"#{k}/#{[v].flatten.join(",")}"}.join(";") unless @params.empty?
      make_call
    end

    private

    def make_call
      response = HTTParty.get self.request_url
      JSON.parse response.body
    end

  end
end
