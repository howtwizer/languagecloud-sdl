require 'active_support/ordered_options'
require 'forwardable'
require 'delegate'
require 'json'

module LanguagecloudSdl
  class Response < SimpleDelegator
    extend Forwardable

    def_delegators :@parsed, :wordCount, :charCount,
                   :from, :to, :translations, :partialTranslation

    def initialize(response)
      super(response)
      @parsed = ActiveSupport::InheritableOptions.new(JSON.parse(response.body).with_indifferent_access)
    end

    alias_method :original_response, :__getobj__
  end
end
