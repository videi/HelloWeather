import Foundation
import UIKit
import SnapKit

final class DailyCell: UITableViewCell {
    static let identifier = "DailyCell"
    
    private let dateStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 2
        return stack
    }()
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .lightGray
        return label
    }()
    
    private let infoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 16
        return stack
    }()
    
    private let iconView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let minTempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .white.withAlphaComponent(0.6)
        label.textAlignment = .right
        return label
    }()
    
    private let maxTempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        contentView.addSubview(dateStackView)
        contentView.addSubview(infoStackView)
        
        dateStackView.addArrangedSubview(dayLabel)
        dateStackView.addArrangedSubview(dateLabel)
        
        infoStackView.addArrangedSubview(iconView)
        infoStackView.addArrangedSubview(minTempLabel)
        infoStackView.addArrangedSubview(maxTempLabel)
    }
    
    private func setupConstraints() {
        dateStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        infoStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(dateStackView)
        }
        
        iconView.snp.makeConstraints { make in
            make.size.equalTo(30)
        }
        
        minTempLabel.snp.makeConstraints { make in
            make.width.equalTo(45)
        }
        
        maxTempLabel.snp.makeConstraints { make in
            make.width.equalTo(45)
        }
    }
    
    func configure(with model: DailyWeatherModel) {
        dateLabel.text = model.date
        dayLabel.text = model.day
        minTempLabel.text = model.minTemp
        maxTempLabel.text = model.maxTemp
        iconView.loadImage(from: model.iconUrl)
    }
}
