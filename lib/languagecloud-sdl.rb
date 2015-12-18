require 'languagecloud-sdl/version'

require 'json'
require 'httparty'
require 'active_support/hash_with_indifferent_access'
require 'active_support/core_ext/hash'
require 'thread'

require 'languagecloud-sdl/response'

module LanguagecloudSdl
  class API
    include HTTParty

    base_uri 'https://lc-api.sdl.com'

    attr_accessor :api_key, :source_lang

    def initialize(options = {})
      @api_key = options.fetch(:api_key)
      @source_lang = options.fetch(:source_lang)
    end

    def async
      @async = true
      self
    end

    def sync
      @async = false
      self
    end

    # @param [String] to_lang
    # @param [Hash] params
    # {
    #   'texts': [
    #     'text a',
    #     'text b'
    #   ]
    # }
    # Translating array of strings
    def translations(to_lang, params = {})
      params = normalized_params(params)
      params[:from] = source_lang
      params[:to] = to_lang
      call_sdl do
        res = self.class.post('/translations', body: params.to_json, headers: headers_auth)
        res = LanguagecloudSdl::Response.new(res)
        yield res if block_given? or return res
      end
    end

    private

    def call_sdl(&block)
      if @async
        call_async(&block)
      else
        yield
      end
    end

    def call_async(&block)
      Thread.abort_on_exception = false
      Thread.new do |t|
        block.call
      end
      nil
    end

    def normalized_params(params)
      params.with_indifferent_access
    end

    def headers_auth
      {
          "Content-type" => "application/json",
          "Authorization" =>"LC apiKey=#{api_key}"
      }
    end

  end
end
