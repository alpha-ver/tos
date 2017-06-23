module Tos
  class Agent

    def http(url)
      uri = url2uri(url)
      http         = Net::HTTP.new(uri.host, uri.port)
      response     = http.get(uri.request_uri)
      if response.code == "302" && response.header['location'] != ""
        response.header['location']
      elsif response.code == "200"
        response.body
      elsif response.code == "502"
        ap response.code
        ap response.body
        http(url)
      else
        ap uri.to_s
        ap response.code
        ap response.body
      end
    end




    private

      def url2uri(url)
        if url.class == URI::HTTP || url.class == URI::HTTPS
          url
        elsif url.class == String
          URI(url)
        else
          raise Error.new('Undefine type url. Not String or URI.')
        end
      end

  end
end
