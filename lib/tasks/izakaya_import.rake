require 'csv'
require 'httparty'

namespace :izakaya do
  desc "居酒屋情報登録"
  task import: :environment do
    api_key = ENV['GOOGLEMAPS_API_KEY']
    csv_file_path = 'lib/assets/izakayas.csv'

    CSV.foreach(csv_file_path, headers: true) do |row|
      name = row['name']
      next if name.blank?

      # Google Places APIリクエスト
      url = "https://maps.googleapis.com/maps/api/place/textsearch/json"
      params = {
        input: "#{name} 西成 新世界",
        inputtype: 'textquery',
        fields: 'name,geometry,formatted_address,photos,opening_hours',
        language: 'ja',
        key: api_key
      }
      response = HTTParty.get(url, query: params)
      result = response['results'].find { |place| place['formatted_address'].include?('西成区') || place['formatted_address'].include?('浪速区')  || place['formatted_address'].include?('Nishinari Ward')  || place['formatted_address'].include?('Naniwa Ward') }

      if result
        photo_reference = result.dig('photos', 0, 'photo_reference')
        image_url = nil

        if photo_reference
          photo_url = "https://maps.googleapis.com/maps/api/place/photo"
          photo_params = {
            maxwidth: 400,
            photoreference: photo_reference,
            key: api_key
          }
          photo_response = HTTParty.get(photo_url, query: photo_params, follow_redirects: false)

          if photo_response.code == 302
            image_url = photo_response.headers['location']
          end
        end

        Izakaya.create(
          name: result['name'],
          lat: result['geometry']['location']['lat'],
          lng: result['geometry']['location']['lng'],
          photo_reference: photo_reference,
          opening_hours: result.dig('opening_hours', 'weekday_text')&.join("\n"),
          formatted_address: result['formatted_address'],
          image: image_url
        )
        puts "#{name}を保存しました"
      else
        puts "#{name}の保存に失敗しました"
      end
    end
  end
end