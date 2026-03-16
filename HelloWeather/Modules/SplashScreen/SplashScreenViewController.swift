import UIKit

protocol SplashViewProtocol: AnyObject {}

final class SplashScreenViewController: UIViewController {
    
    // MARK: - Property
    
    private let contentView = SplashScreenView()
    private let presenter: SplashPresenterProtocol
    
    // MARK: - Init
    
    init(presenter: SplashPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTarget()
        setupBinding()
        
        presenter.getLocation()
    }
    
    // MARK: - Setup
    
    private func setupTarget() {
        
    }
    
    private func setupBinding() {
        
    }
    
    // MARK: - Action
    
}
