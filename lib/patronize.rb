require 'json'
require 'geo_ruby'
require 'geo_ruby/geojson'

class Hash
  def as_json(options)
    self
  end
end

def feature_to_string(feature)
  [
    "  Name:      #{feature.properties['name']}",
    "  Address:   #{feature.properties['address']}",
    "  Latitude:  #{feature.geometry.y}",
    "  Longitude: #{feature.geometry.x}"
  ].join("\n")
end

def features_eql?(f, feature)
  f.geometry.x.eql?(feature.geometry.x) &&
    f.geometry.y.eql?(feature.geometry.y)
end

def add_feature(feature_collection, feature)
  feature_collection.features.reject! { |f| features_eql?(f, feature) }
  feature_collection.features << feature
  puts "Added the following:"
  puts feature_to_string(feature)
  feature_collection
end

def add_feature_to_city(city, options)
  p options
  write_features_for_city(
    city,
    add_feature(
      city_features_collection(city),
      feature_for_input(options)))
end

def city_geojson(city)
  geojson = if File.exists? city_geojson_file(city)
    File.read city_geojson_file(city)
  else
    ""
  end
end

def city_geojson_file(city)
  "cities/#{city}.geojson"
end

def city_features_collection(city)
  geojson = city_geojson(city)
  if geojson.nil? || geojson.empty?
    GeoRuby::GeoJSONFeatureCollection.new []
  else
    GeoRuby::GeoJSONParser.new.parse geojson
  end
end

def feature_for_input(options)
  GeoRuby::GeoJSONFeature.new(
    GeoRuby::SimpleFeatures::Point.from_x_y(options.fetch('lon'), options.fetch('lat')),
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
  File.open(city_geojson_file(city), 'wb') do |f|
    f.puts city_features.to_json
  end
end
