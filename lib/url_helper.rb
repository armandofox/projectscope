module UrlHelper
    require "net/http"

    # url_string must be a full http url
    def self.url_exist?(url_string)
      if not self.proper_url?(url_string)
        return false
      end
      url = URI.parse(url_string)
      req = Net::HTTP.new(url.host, url.port)
      req.use_ssl = (url.scheme == 'https')
      path = url.path if url.path.present?
      res = req.request_head(path || '/')
      if res.kind_of?(Net::HTTPRedirection)
        self.url_exist?(res['location']) # Go after any redirect and make sure you can access the redirected URL 
      else
        ! %W(4 5).include?(res.code[0]) # Not from 4xx or 5xx families
      end
    rescue Errno::ENOENT, SocketError, URI::InvalidURIError
      false #false if can't find the server
    end
    
    # Ensure url_string passes format whitelist
    # Format is:
    # http(s)://<stuff>.stuff.stuff/<stuff>
    # The regex is not exhaustive but will serve its purposes for the URLs this
    # project will see.
    def self.proper_url?(url_string)
      if not url_string
        return false
      end
      regex = /^https?:\/\/([\w-]+\.)?[\w-]+\.[\w-]+(\/[\S]*)?$/i
      if url_string =~ regex
        true
      else
        false
      end
    end
end