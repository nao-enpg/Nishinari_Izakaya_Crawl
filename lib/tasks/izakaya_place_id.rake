require 'open-uri'
require 'json'

namespace :izakaya do
  desc "既存のizakayaデータベースにplace_idを追加"
  task update_place_ids: :environment do
    api_key = ENV['GOOGLEMAPS_API_KEY']

    Izakaya.find_each do |izakaya|
      if izakaya.place_id.blank?
        formatted_address = izakaya.formatted_address

        if formatted_address.blank?
          puts "居酒屋ID #{izakaya.id} の住所が見つかりません"
          next
        end

        puts "住所: #{formatted_address}"

        # Google Places API Text Searchリクエスト
        url = "https://maps.googleapis.com/maps/api/place/textsearch/json"
        params = {
          query: formatted_address,
          key: api_key,
          language: 'ja'
        }
        query_string = URI.encode_www_form(params)
        request_url = "#{url}?#{query_string}"

        response = URI.open(request_url).read
        place_search_result = JSON.parse(response)

        puts "Place search response for #{izakaya.name}: #{place_search_result}"

        if place_search_result['status'] == 'OK' && place_search_result['results'].present?
          place_id = place_search_result['results'].first['place_id']
          puts "Place ID for #{izakaya.name}: #{place_id}"

          izakaya.update(place_id: place_id)
          puts "#{izakaya.name}のPlace IDを更新しました"
        else
          puts "#{izakaya.name}の住所に適切な場所が見つかりませんでした"
        end
      else
        puts "既存のPlace IDを使用: #{izakaya.place_id} for #{izakaya.name}"
      end
    end
  end
end
