require 'open-uri'
require 'json'

namespace :izakaya do
  desc "既存のizakayaデータベースに営業時間を追加"
  task update_opening_hours: :environment do
    api_key = ENV['GOOGLEMAPS_API_KEY']
    izakaya_id = ENV['IZAKAYA_ID']

    izakaya = Izakaya.find_by(id: izakaya_id)
    if izakaya.nil?
      puts "居酒屋ID #{izakaya_id} が見つかりません"
      next
    end

    # Google Places API Place Detailsリクエスト
    def get_detail_data(sauna)
      place_id = izakaya.place_id

      if place_id
        # クエリパラメータの作成
        place_detail_query = URI.encode_www_form(
          place_id: place_id,
          language: 'ja',
          key: api_key
        )
        # Places APIのエンドポイントの作成
        place_detail_url = "https://maps.googleapis.com/maps/api/place/details/json?#{place_detail_query}"
        # APIから取得したデータをテキストデータ(JSON形式)で取得し変数に格納
        place_detail_page = URI.open(place_detail_url).read
        # JSON形式のデータをRubyオブジェクトに変換
        place_detail_data = JSON.parse(place_detail_page)

        #取得したデータを保存するカラム名と同じキー名で、ハッシュ（result）に保存
        result = {}
        result[:opening_hours] = place_detail_data['result']['opening_hours']['weekday_text'].join("\n") if place_detail_data['result']['opening_hours'].present?
        result
      else
        puts "詳細情報が見つかりませんでした。"
        nil
      end
    end
  end
end
