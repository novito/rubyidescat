module Rubyidescat
  class Client
    BASE_URL = 'http://api.idescat.cat/'
    VERSION = "v1"

    def initialize(attributes = {})
      attributes.each do |attr, value|
        self.send("#{attr}=", value)
      end
      @format = "json"
    end

    #
    # Gets the population information for each area specified by
    # the operation and the params
    #
    # @param  operation [String] Operation to be made. Could be "cerca" or "sug"
    # see http://www.idescat.cat/dev/api/pob/?lang=en#a1.1.2. for more information
    # @param  params = {} [Hash] Parameters for the API query
    # see http://www.idescat.cat/dev/api/pob/?lang=en#a1.2. for more information
    #
    # @return [JSON, String or XML] The API response with the specified format
    #
    def get_population(operation, params = {})
      build_custom_url('pob', operation, params)
      make_call
    end

    #
    # Gets the rectification information 
    #
    # @param  operation [String] Operation to be made. Could be "cerca" or "categories"
    # @param  params = {} [Hash] Parameters for the API query
    # see http://www.idescat.cat/dev/api/rectificacions/?lang=en#a1.1.2. for more information
    #
    # @return [JSON, String or XML] The API response with the specified format
    #
    def get_rectifications(operation, params = {})
      build_standard_url('rectificacions', operation, params)
      make_call
    end

    
    private
      #
      # Makes the HTTP call to the API service using the @request_url
      #
      # @return [JSON, String or XML] The API response with the specified format
      #
      def make_call
        response = HTTParty.get(URI.escape(@request_url))
        return parse_response(response.body)
      end

      #
      # Parses the response to match the format requested
      # @param  response [String] The api response
      #
      # @return [JSON, String or XML] The API response with the specified format
      #
      def parse_response(response)
        # @todo Parse the response based on the @format ("txt", "json" or "xml")
        JSON.parse(response)
      end

      #
      # Sets the @request_url for the given service using an Idescat custom way of building a URL 
      #
      # @param  endpoint [String] The endpoint to call 
      # @param  operation [String] Operation to be made. Could be "cerca" or "sug"
      # @param  params = {} [Hash] Parameters for the API query
      # see http://www.idescat.cat/dev/api/pob/?lang=en#a1.1.2. for more information
      #
      # @return [String] The request url 
      #
      def build_custom_url(endpoint, operation, params = {})
        @request_url = BASE_URL + endpoint + '/' + VERSION + '/' + operation + '.' + @format
        @request_url += '?p=' + params.map{|k,v|"#{k}/#{[v].flatten.join(",")}"}.join(";") unless params.empty?
      end

      #
      # Sets the @request_url for the rectifications call using the standard way of building URLs
      #
      # @param  endpoint [String] The endpoint to call 
      # @param  operation [String] Operation to be made. Could be "cerca" or "categories"
      # @param  params = {} [Hash] Parameters for the API query
      # see http://www.idescat.cat/dev/api/rectificacions/?lang=en#a1.1.2. for more information
      #
      # @return [String] The request url 
      #
      def build_standard_url(endpoint, operation, params = {})
        @request_url = BASE_URL + 'rectificacions' + '/' + VERSION + '/' + operation + '.' + @format
        @request_url += '?p=' + params.map{|k,v|"#{k}=#{[v].flatten.join(",")}"}.join("&") unless params.empty?
      end
  end
end
