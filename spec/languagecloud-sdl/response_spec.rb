require 'spec_helper'

describe LanguagecloudSdl::Response do
  subject do
    LanguagecloudSdl::Response.new(WebMock::Response.new(body: result.to_json))
  end

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

  describe "delegates to the response object" do
    its(:translations)       { should == result['translations'] }
    its(:partialTranslation)     { should == result['partialTranslation'] }
    its(:from) { should == result['from'] }
    its(:to)   { should == result['to'] }
    its(:wordCount)   { should == result['wordCount'] }
    its(:charCount)    { should == result['charCount'] }
  end

  describe "still responds to HTTP response methods" do
    its(:status) { should eq [200, ''] }
  end
end