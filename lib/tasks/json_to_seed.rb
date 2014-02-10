def parse_airports
  air_file = ActiveSupport::JSON.decode(File.read("lib/places/airports.json"))

  string = "Place.create([
  "

  air_file.each do |airport|
    type_id = airport["type_id"].to_s
    name = airport["name"]
    latitude = airport["lat"]
    longitude = airport["lng"]

    start_string = "{ name: "
    name_string = "'#{name}'"
    start_two_string = ", type_id: "
    id_string = type_id
    start_latitude_string = ", lat: "
    latitude_string = latitude.to_s
    start_longitude_string = ", lng: "
    longitude_string = longitude.to_s
    end_string = " },
"
    string << start_string <<  name_string << start_two_string << id_string << start_latitude_string << latitude_string << start_longitude_string << longitude_string << end_string
  end
  string << "])"

  File.open("lib/places/airports_seeds.rb", "w") { |file| file.write string }
end