import SwiftUI
import UIKit
import SnapKit

class SplashScreenView: UIView {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Controls
    
    private let logoLabel: UILabel = {
        let label = UILabel()
        
        let config = UIImage.SymbolConfiguration(paletteColors: [.white, .systemYellow])
        let symbolConfig = config.applying(UIImage.SymbolConfiguration(pointSize: 30, weight: .bold))
        
        let image = UIImage(systemName: "cloud.sun.fill", withConfiguration: symbolConfig)
        
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = CGRect(x: 0, y: -5, width: image?.size.width ?? 0, height: image?.size.height ?? 0)
        
        let fullString = NSMutableAttributedString(attachment: attachment)

        let helloAttr: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]
        let helloString = NSAttributedString(string: " Hello", attributes: helloAttr)

        let worldAttr: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.systemYellow]
        let worldString = NSAttributedString(string: " Weather", attributes: worldAttr)

        fullString.append(helloString)
        fullString.append(worldString)

        label.attributedText = fullString
        label.font = .systemFont(ofSize: 32, weight: .bold)
        return label
    }()
    
    // MARK: - Setup
    
    private func setupUI() {
        self.backgroundColor = .systemBlue
        self.addSubview(logoLabel)
    }
    
    private func setupConstraints() {
        self.logoLabel.snp.makeConstraints { $0.center.equalToSuperview() }
    }
}

#Preview {
    SplashScreenView().showLivePreview()
}
