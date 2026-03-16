import Foundation

protocol MainPresenterProtocol {
    func getWeatherInfo()
}

final class MainPresenter: MainPresenterProtocol {
    
    // MARK: - Property
    
    private let router: MainRouter
    private let weatherNetworkService: WeatherNetworkProtocol
    private let geoLocation: GeoLocation

    weak var view: MainViewProtocol?
    
    // MARK: - Closure
        
    // MARK: - Init
    
    init(router: MainRouter, weatherNetworkService: WeatherNetworkProtocol, geoLocation: GeoLocation) {
        self.router = router
        self.weatherNetworkService = weatherNetworkService
        self.geoLocation = geoLocation
    }
    
    // MARK: - Method

    func getWeatherInfo() {
        let group = DispatchGroup()
        
        var currentWeather: CurrentWeatherModel?
        var forecastWeather: ForecastWeatherModel?
        var fetchError: Error?
        
        view?.showLoading()
        
        group.enter()
        weatherNetworkService.getCurrent(lat: geoLocation.latitude, lon: geoLocation.longitude) { result in
            switch result {
            case .success(let response):
                currentWeather = CurrentWeatherModel(
                    temp: response.current.tempC,
                    city: response.location.name,
                    condition: response.current.condition.text
                )
            case .failure(let error):
                fetchError = error
            }
            group.leave()
        }
        
        group.enter()
        weatherNetworkService.getForecast(lat: geoLocation.latitude, lon: geoLocation.longitude, days: 3) { [weak self] result in
            switch result {
            case .success(let response):
                forecastWeather = self?.mapForecastData(response)
            case .failure(let error):
                fetchError = error
            }
            group.leave()
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.view?.hideLoading()
            
            if let error = fetchError {
                print(error)
                self?.view?.showError()
                return
            }
            
            guard let current = currentWeather, let forecast = forecastWeather else { return }
            
            self?.view?.displayWeatherInfo(
                currentWeather: current,
                rangeTemp: forecast.rangeTemp,
                hourly: forecast.hourly,
                daily: forecast.daily
            )
        }
    }
        
    private func mapForecastData(_ response: WeatherResponse) -> ForecastWeatherModel {
        let days = response.forecast?.forecastday ?? []
        
        let currentHour = Calendar.current.component(.hour, from: Date())
        let todayHours = days.first?.hour.filter { hour in
            let hourValue = Int(hour.time.suffix(5).prefix(2)) ?? 0
            return hourValue >= currentHour
        } ?? []
        let tomorrowHours = days[1].hour
        let combinedHours = (todayHours + tomorrowHours).map { hour in
            HourlyWeatherModel(
                time: self.formatTime(hour.time),
                iconUrl: hour.condition.icon,
                temp: "\(Int(hour.tempC))°"
            )
        }
        
        let today = days.first?.day
        let rangeTemp = (today?.mintempC ?? 0.0, today?.maxtempC ?? 0.0)
        
        let daily = days.map { day -> DailyWeatherModel in
            return DailyWeatherModel(
                date: self.formatDate(day.date),
                day: self.formatDay(day.date),
                iconUrl: day.day.condition.icon,
                minTemp: "\(Int(day.day.mintempC))°",
                maxTemp: "\(Int(day.day.maxtempC))°"
            )
        }
        
        return ForecastWeatherModel(rangeTemp: rangeTemp, hourly: combinedHours, daily: daily)
    }
    
    private func formatDate(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = formatter.date(from: dateString) else { return "" }
        
        formatter.dateFormat = "d MMMM"
        return formatter.string(from: date)
    }
    
    private func formatDay(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = formatter.date(from: dateString) else { return "" }
        
        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            return "Today"
        } else if calendar.isDateInTomorrow(date) {
            return "Tomorrow"
        } else {
            formatter.dateFormat = "EEEE"
            return formatter.string(from: date).capitalized
        }
    }
    
    private func formatTime(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        guard let date = formatter.date(from: dateString) else { return "--:--" }
        
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}
