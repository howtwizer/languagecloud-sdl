require 'spec_helper'
require 'timeout'

describe LanguagecloudSdl::API do
  let(:result) do
    {
        "translations" => [
            "Texte à traduire",
            "Texte à traduire"
        ],
        "partialTranslation" => false,
        "from" => "eng",
        "to" => "fra",
        "wordCount" => 8,
        "charCount" => 36
    }
  end

  subject { LanguagecloudSdl::API.new(api_key: 'xxxxxxxxxxxxxx', source_lang: 'eng') }

  describe 'initialize' do
    it 'is an error to leave out the key or secret' do
      expect { LanguagecloudSdl::API.new(api_secret: 2) }.to raise_error KeyError
      expect { LanguagecloudSdl::API.new(source_lang: 'eng') }.to raise_error KeyError
    end
  end

  describe '#async' do
    let(:expected_params) do
      {
          'texts' => ['a', 'b'],
          'from' => 'fra',
          'to' => 'eng'
      }
    end

    it 'returns the result eventually' do
      stub_request(:post, "https://lc-api.sdl.com/translations").
          with(:body => "{\"texts\":[\"a\",\"b\"],\"from\":\"eng\",\"to\":\"fra\"}",
               :headers => {'Authorization'=>'LC apiKey=xxxxxxxxxxxxxx', 'Content-Type'=>'application/json'}).
          to_return(:status => 200, :body => result.to_json, :headers => {})

      defer = nil
      immediate = subject.async.translations('fra', {texts: ['a', 'b']}) do |result|
        defer = result.from
      end

      expect(immediate).to be_nil

      Timeout.timeout(2) do
        loop until defer
      end

      expect(defer).to eq result['from']
    end
  end


  describe '#translations' do
    let(:expected_params) do
      {
          'texts' => ['a', 'b'],
          'from' => 'fra',
          'to' => 'eng'
      }
    end

    it 'provides text to sdl api' do

      options = {
        texts: ['a', 'b']
      }
      stub_request(:post, "https://lc-api.sdl.com/translations").
          with(:body => "{\"texts\":[\"a\",\"b\"],\"from\":\"eng\",\"to\":\"fra\"}",
               :headers => {'Authorization'=>'LC apiKey=xxxxxxxxxxxxxx', 'Content-Type'=>'application/json'}).
          to_return(:status => 200, :body => result.to_json, :headers => {})
      res = subject.translations('fra', options)
      expect(res.code).to eq 200
    end
  end


end
