import UIKit

protocol MainViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func displayWeatherInfo(currentWeather: CurrentWeatherModel, rangeTemp: (minTemp: Double, maxTemp: Double), hourly: [HourlyWeatherModel], daily: [DailyWeatherModel])
    func showError()
}

final class MainViewController: UIViewController {
    
    // MARK: - Property
    
    private let mainView = MainView()
    private let presenter: MainPresenterProtocol
    private var hourlyData: [HourlyWeatherModel] = []
    private var dailyData: [DailyWeatherModel] = []
    
    // MARK: - Init
    
    init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true

        mainView.tempLabel.text = "- -"
        
        mainView.collectionView.dataSource = self
        mainView.tableView.dataSource = self
        
        setupTarget()
        setupBinding()
        
        getWeatherInfo()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Setup
    
    private func setupTarget() {}
    
    private func setupBinding() {}
    
    // MARK: - Action
    private func getWeatherInfo() {
        presenter.getWeatherInfo()
    }
}

extension MainViewController: MainViewProtocol {
    func showLoading() {
        mainView.loader.startAnimating()
        view.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0.3) {
            self.mainView.scrollView.alpha = 0.3
        }
    }
    
    func hideLoading() {
        mainView.loader.stopAnimating()
        view.isUserInteractionEnabled = true
        
        UIView.animate(withDuration: 0.3) {
            self.mainView.scrollView.alpha = 1.0
        }
    }
    
    func displayWeatherInfo(currentWeather: CurrentWeatherModel, 
                            rangeTemp: (minTemp: Double, maxTemp: Double),
                            hourly: [HourlyWeatherModel],
                            daily: [DailyWeatherModel]) {
        mainView.cityLabel.text = currentWeather.city
        mainView.tempLabel.text = "\(Int(currentWeather.temp))°"
        mainView.conditionLabel.text = currentWeather.condition
        
        mainView.tempRangeLabel.text = "Макс: \(Int(rangeTemp.maxTemp))°, мин: \(Int(rangeTemp.minTemp))°"
        
        self.hourlyData = hourly
        mainView.collectionView.reloadData()
        
        self.dailyData = daily
        mainView.tableView.reloadData()
        
        mainView.conditionLabel.isHidden = false
        mainView.tempRangeLabel.isHidden = false
        mainView.hourlyContainer.isHidden = false
        mainView.dailyContainer.isHidden = false
    }
    
    func showError() {
        mainView.tempLabel.text = "- -"
        mainView.cityLabel.text = ""
        
        mainView.conditionLabel.isHidden = true
        mainView.tempRangeLabel.isHidden = true
        mainView.hourlyContainer.isHidden = true
        mainView.dailyContainer.isHidden = true
        
        let alert = UIAlertController(title: "Oops!", message: "Something went wrong. Please check your connection.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { [weak self] _ in
            self?.getWeatherInfo()
        }))
        present(alert, animated: true)
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCell.identifier, for: indexPath) as! HourlyCell
        cell.configure(with: hourlyData[indexPath.item])
        return cell
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DailyCell.identifier, for: indexPath) as! DailyCell
        cell.configure(with: dailyData[indexPath.row])
        return cell
    }
}
