require 'net/http'
require 'uri'
require 'json'

# 言語の種類を検出するメソッド
# moduleで内容の定義位置を指定class>>selfで、
# Translate.translate_to_japaneseみたいな定義の仕方をできるようにする
module Translate
  class << self
    def lang_data(context)
      url = URI.parse('https://translation.googleapis.com/language/translate/v2/detect')
      params = {
          q: context,
          key: ENV['GOOGLE_API_KEY']
       }
      url.query = URI.encode_www_form(params)
      res = Net::HTTP.get_response(url)
      json = res.body
  # レスポンスのjsonの言語のパラメータをパースする
      JSON.parse(json)["data"]["detections"][0][0]["language"]
    end

    def translate_to_japanese(context)
      url = URI.parse('https://www.googleapis.com/language/translate/v2')
      params = {
          q: context,
          target: "ja", # 翻訳したい言語
          source: lang_data(context), # 翻訳する言語の種類
          key: ENV['GOOGLE_API_KEY']
      }
      url.query = URI.encode_www_form(params)
      res = Net::HTTP.get_response(url)
      json = res.body
  # レスポンスのjsonの言語の翻訳結果の部分のパラメータをパースする
      "#{JSON.parse(json)["data"]["translations"].first["translatedText"]}"
    end
  end
end