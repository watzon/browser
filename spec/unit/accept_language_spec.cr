require "../spec_helper"

Spectator.describe Browser::AcceptLanguage do
  def assert_language(item, **expectation)
    expect(expectation[:code]).to eq(item.code)

    if region = expectation[:region]?
      expect(region).to eq(item.region)
    else
      expect(item.region).to be_nil
    end

    expect(expectation[:quality]).to eq(item.quality)
  end

  it "returns full language" do
    language = Browser::AcceptLanguage.new("en-GB")
    expect(language.full).to eq("en-GB")
  end

  it "returns language name" do
    language = Browser::AcceptLanguage.new("en-GB")
    expect(language.name).to eq("English/United Kingdom")

    language = Browser::AcceptLanguage.new("en")
    expect(language.name).to eq("English")
  end

  it "returns nil for unknown languages" do
    language = Browser::AcceptLanguage.new("unknown")
    expect(language.name).to be_nil
  end

  it "returns the language code" do
    language = Browser::AcceptLanguage.new("en-GB")
    expect(language.code).to eq("en")
  end

  it "returns a formatted code" do
    ["EN-GB", "En-GB", "eN-GB"].each do |locale|
      language = Browser::AcceptLanguage.new(locale)
      expect(language.code).to eq("en")
    end
  end

  it "returns the region" do
    language = Browser::AcceptLanguage.new("en-GB")
    expect(language.region).to eq("GB")
  end

  it "returns a formatted region" do
    ["EN-GB", "En-GB", "eN-GB"].each do |locale|
      language = Browser::AcceptLanguage.new(locale)
      expect(language.region).to eq("GB")
    end
  end

  it "returns nil for a language with no region" do
    language = Browser::AcceptLanguage.new("en")
    expect(language.region).to be_nil
  end

  it "parses language with quality" do
    language = Browser::AcceptLanguage.new("en-GB;q=0.8")
    assert_language(language, code: "en", region: "GB", quality: 0.8)
  end

  it "parses language without quality" do
    language = Browser::AcceptLanguage.new("en-GB")
    assert_language(language, code: "en", region: "GB", quality: 1.0)
  end

  it "parses language without region" do
    language = Browser::AcceptLanguage.new("en")
    assert_language(language, code: "en", region: nil, quality: 1.0)
  end

  it "parses language with multi-part region" do
    language = Browser::AcceptLanguage.new("az-AZ-Cyrl")
    assert_language(language, code: "az", region: "AZ", quality: 1.0)
  end

  it "parses multi-language set" do
    result = Browser::AcceptLanguage.parse("fr-CA,fr;q=0.8")

    expect(result.size).to eq(2)
    assert_language(result[0], code: "fr", region: "CA", quality: 1.0)
    assert_language(result[1], code: "fr", region: nil, quality: 0.8)
  end

  it "parses wildcard" do
    result = Browser::AcceptLanguage.parse("fr-CA,*;q=0.8")

    assert_language(result[0], code: "fr", region: "CA", quality: 1.0)
    assert_language(result[1], code: "*", region: nil, quality: 0.8)
  end

  it "parses complex set" do
    accept_language = "fr-CA,fr;q=0.8,en-US;q=0.6,en;q=0.4,*;q=0.1"
    result = Browser::AcceptLanguage.parse(accept_language)

    assert_language(result[0], code: "fr", region: "CA", quality: 1.0)
    assert_language(result[1], code: "fr", region: nil, quality: 0.8)
    assert_language(result[2], code: "en", region: "US", quality: 0.6)
    assert_language(result[3], code: "en", region: nil, quality: 0.4)
    assert_language(result[4], code: "*", region: nil, quality: 0.1)
  end

  it "handles random white space" do
    accept_language = "fr-CA, fr;q=0.8,  en-US;q=0.6,en;q=0.4,    *;q=0.1"
    result = Browser::AcceptLanguage.parse(accept_language)

    assert_language(result[0], code: "fr", region: "CA", quality: 1.0)
    assert_language(result[1], code: "fr", region: nil, quality: 0.8)
    assert_language(result[2], code: "en", region: "US", quality: 0.6)
    assert_language(result[3], code: "en", region: nil, quality: 0.4)
    assert_language(result[4], code: "*", region: nil, quality: 0.1)
  end

  it "sorts based on quality" do
    accept_language = "fr-CA,fr;q=0.2,en-US;q=0.6,en;q=0.4,*;q=0.5"
    result = Browser::AcceptLanguage.parse(accept_language)

    assert_language(result[0], code: "fr", region: "CA", quality: 1.0)
    assert_language(result[1], code: "en", region: "US", quality: 0.6)
    assert_language(result[2], code: "*", region: nil, quality: 0.5)
    assert_language(result[3], code: "en", region: nil, quality: 0.4)
    assert_language(result[4], code: "fr", region: nil, quality: 0.2)
  end

  it "sorts the same quality in descending priority" do
    accept_language = "fr-CA,fr;q=0.2,en-US;q=0.2,en"
    result = Browser::AcceptLanguage.parse(accept_language)

    assert_language(result[0], code: "fr", region: "CA", quality: 1.0)
    assert_language(result[1], code: "en", region: nil, quality: 1.0)
    assert_language(result[2], code: "fr", region: nil, quality: 0.2)
    assert_language(result[3], code: "en", region: "US", quality: 0.2)
  end

  it "rejects quality values equal to zero" do
    result = Browser::AcceptLanguage.parse("de-DE,ru;q=0.9,de;q=0.8,en;q=0.")

    expect(result.size).to eq(3)
    assert_language(result[0], code: "de", region: "DE", quality: 1.0)
    assert_language(result[1], code: "ru", region: nil, quality: 0.9)
    assert_language(result[2], code: "de", region: nil, quality: 0.8)
  end

  it "handles invalid quality values that look like a number" do
    accept_language = "fr-CH, fr;q=0.9, en;q=0.8, de;q=0..7, *;q=0.5"
    result = Browser::AcceptLanguage.parse(accept_language)

    expect(result.size).to eq(5)
    assert_language(result[3], code: "de", region: nil, quality: 0.7)
  end

  it "sets the default quality value for invalid strings" do
    result = Browser::AcceptLanguage.parse(";q=0.0.0.0")
    expect(result[0].quality).to eq(0.1)
  end
end
