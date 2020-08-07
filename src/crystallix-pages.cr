module CRYSTALLIX

  SERVER_NAME = ENV["SERVER_NAME"]
  REDIRECT_STATUS = ENV["REDIRECT_STATUS"]
  SERVER_PROTOCOL = ENV["SERVER_PROTOCOL"]
  REQUEST_METHOD = ENV["REQUEST_METHOD"].upcase
  QUERY_STRING = ENV["QUERY_STRING"]
  REMOTE_ADDR = ENV["REMOTE_ADDR"]
  SERVER_PORT = ENV["SERVER_PORT"].to_i
  CONTENT_TYPE = ENV["CONTENT_TYPE"]? ? ENV["CONTENT_TYPE"] : ""
  CONTENT_LENGTH = ENV["CONTENT_LENGTH"]? ? ENV["CONTENT_LENGTH"].to_i : 0
  USER_AGENT = ENV["HTTP_USER_AGENT"]? ? ENV["HTTP_USER_AGENT"] : ""
  ACCEPT = ENV["HTTP_ACCEPT"]? ? ENV["HTTP_ACCEPT"] : ""
  COOKIES = ENV["HTTP_COOKIE"]? ? ENV["HTTP_COOKIE"] : ""
  BODY = STDIN.closed? ? STDIN.gets_to_end.chomp : ""

  class Page

    @body = ""
    @headers = {} of String => String | Array(String)

    def initialize
      @headers["X-Powered-By"] = "Crystallix Page System"
    end

    def echo
      result = ""
      @headers.each do |key, value|
        result += key + ": " + (value.is_a?(Array(String)) ? value.join("; ") : value) + "\n"
      end
      result += "\n" + @body
      puts result
    end

    def close
      echo
    end

    def add (component)
      @body += "#{component}"
    end

    def header (name : String, value : String | Array(String))
      @headers[name] = value
    end
  end
end
