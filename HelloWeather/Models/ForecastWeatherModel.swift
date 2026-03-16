struct ForecastWeatherModel {
    let rangeTemp: (minTemp: Double, maxTemp: Double)
    let hourly: [HourlyWeatherModel]
    let daily: [DailyWeatherModel]
}
