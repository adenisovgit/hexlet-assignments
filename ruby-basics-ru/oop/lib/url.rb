# frozen_string_literal: true
# BEGIN
require 'forwardable'
require 'uri'

class Url
    extend Forwardable
    include Comparable

    def_delegators :@url, :scheme, :host, :port
  
    def initialize(url_string)
      @url = URI(url_string)
      @params = if @url.query
        URI.decode_www_form(@url.query).each_with_object({}) do |(key, value), hash|
          hash[key.to_sym] = value
        end
        else
            {}
        end
    end

    def query_params
        @params
    end

    def query_param(key, default_value = nil)
        @params.has_key?(key.to_sym) ? @params[key] : default_value
    end

    def <=>(other)
        scheme_comp = @url.scheme <=> other.scheme;
        return scheme_comp if !scheme_comp.zero?
        port_comp = @url.port <=> other.port;
        return port_comp if !port_comp.zero?
        host_comp = @url.host <=> other.host;
        return host_comp if !host_comp.zero?
        @params <=> other.query_params
    end
end
# END
