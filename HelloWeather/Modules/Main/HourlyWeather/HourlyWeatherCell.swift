import UIKit
import SnapKit

final class HourlyCell: UICollectionViewCell {
    static let identifier = "HourlyCell"
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private let iconView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        [timeLabel, iconView, tempLabel].forEach { contentView.addSubview($0) }
    }
    
    func setupConstraints() {
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
        }
        
        iconView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(30)
        }
        
        tempLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.centerX.equalToSuperview()
        }
    }
    
    func configure(with model: HourlyWeatherModel) {
        timeLabel.text = model.time
        tempLabel.text = model.temp
        iconView.loadImage(from: model.iconUrl)
    }
}
