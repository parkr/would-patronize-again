require 'geo_ruby'
require 'geo_ruby/geojson'

def add_feature_to_city(city, options)
  features = city_features_collection city
  features.features << feature_for_input(options)
  write_features_for_city city, features
end

def city_geojson(city)
  city_geojson_file = "#{city}.geojson"
  geojson = if File.exists? city_geojson_file
    File.read city_geojson_file
  else
    ""
  end
end

def city_features_collection(city)
  geojson = city_geojson(city)
  if geojson.nil? || geojson.empty?
    GeoRuby::GeojsonFeatureCollection.new []
  else
    GeoRuby::GeojsonParser.new.parse geojson
  end
end

def feature_for_input(options)
  GeoRuby::GeojsonFeature.new(
    GeoRuby::SimpleFeatures::Point.from_x_y(options.fetch('lat'), options.fetch('lon')),
    {
      "marker-size"   => 'large',
      "marker-color"  => '#BE9A6B',
      "marker-symbol" => options.fetch('marker', 'cafe'),
      "name"          => options.fetch('name'),
      "address"       => options.fetch('address', '')
    }
  )
end

def write_features_for_city(city, city_features)
  File.open(city_geojson_file, 'wb') do |f|
    f.puts city_features.to_json
  end
end
