import UIKit
import SnapKit

final class SunLoaderView: UIView {
    
    private let sunImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "sun.max.fill")
        iv.tintColor = .systemYellow
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        addSubview(sunImageView)
        sunImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func startAnimating() {
        self.isHidden = false
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 2
        rotation.isCumulative = true
        rotation.repeatCount = Float.infinity
        
        sunImageView.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    func stopAnimating() {
        sunImageView.layer.removeAnimation(forKey: "rotationAnimation")
        self.isHidden = true
    }
}


