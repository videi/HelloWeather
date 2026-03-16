struct WeatherResponse: Decodable {
    let location: Location
    let current: Current
    let forecast: Forecast?
}

struct Location: Decodable {
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let tzId: String
    let localtimeEpoch: Int
    let localtime: String

    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon
        case tzId = "tz_id"
        case localtimeEpoch = "localtime_epoch"
        case localtime
    }
}

struct Current: Decodable {
    let lastUpdatedEpoch: Int
    let lastUpdated: String
    let tempC: Double
    let tempF: Double
    let isDay: Int
    let condition: Condition
    let windMph: Double
    let windKph: Double
    let humidity: Int
    let cloud: Int
    let feelslikeC: Double
    let visKm: Double
    let uv: Double

    enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch = "last_updated_epoch"
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case humidity, cloud
        case feelslikeC = "feelslike_c"
        case visKm = "vis_km"
        case uv
    }
}

struct Forecast: Decodable {
    let forecastday: [ForecastDay]
}

struct ForecastDay: Decodable {
    let date: String
    let dateEpoch: Int
    let day: Day
    let astro: Astro
    let hour: [Hour]

    enum CodingKeys: String, CodingKey {
        case date, day, astro, hour
        case dateEpoch = "date_epoch"
    }
}

struct Day: Decodable {
    let maxtempC: Double
    let mintempC: Double
    let avgtempC: Double
    let maxwindKph: Double
    let totalprecipMm: Double
    let condition: Condition
    let uv: Double

    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case mintempC = "mintemp_c"
        case avgtempC = "avgtemp_c"
        case maxwindKph = "maxwind_kph"
        case totalprecipMm = "totalprecip_mm"
        case condition, uv
    }
}

struct Hour: Decodable {
    let timeEpoch: Int
    let time: String
    let tempC: Double
    let isDay: Int
    let condition: Condition
    let windKph: Double
    let humidity: Int
    let feelslikeC: Double

    enum CodingKeys: String, CodingKey {
        case timeEpoch = "time_epoch"
        case time
        case tempC = "temp_c"
        case isDay = "is_day"
        case condition
        case windKph = "wind_kph"
        case humidity
        case feelslikeC = "feelslike_c"
    }
}

struct Astro: Decodable {
    let sunrise, sunset, moonrise, moonset: String
    let moonPhase: String
    let moonIllumination: Int

    enum CodingKeys: String, CodingKey {
        case sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case moonIllumination = "moon_illumination"
    }
}

struct Condition: Codable {
    let text: String
    let icon: String
    let code: Int
}
