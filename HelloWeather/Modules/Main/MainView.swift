import SwiftUI
import UIKit
import SnapKit

class MainView: UIView {
    
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
    
    private let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "weather_bg")
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .systemBlue
        return iv
    }()
    private let contentView = UIView()

    let scrollView = UIScrollView()
    
    let headerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 4
        return stack
    }()
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 34, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let tempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 96, weight: .thin)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let conditionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .white.withAlphaComponent(0.8)
        label.textAlignment = .center
        return label
    }()
    
    let tempRangeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let hourlyContainer: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .systemThinMaterialDark)
        let view = UIVisualEffectView(effect: blur)
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    let dailyContainer: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .systemThinMaterialDark)
        let view = UIVisualEffectView(effect: blur)
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        tv.isScrollEnabled = false
        tv.separatorColor = .white.withAlphaComponent(0.2)
        tv.register(DailyCell.self, forCellReuseIdentifier: DailyCell.identifier)
        return tv
    }()
    
    let loader = SunLoaderView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 60, height: 110)
        layout.minimumInteritemSpacing = 10
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.register(HourlyCell.self, forCellWithReuseIdentifier: HourlyCell.identifier)
        return cv
    }()
    
    // MARK: - Setup
    
    private func setupUI() {
        addSubview(backgroundImageView)
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        addSubview(loader)
        
        [cityLabel, tempLabel, conditionLabel, tempRangeLabel].forEach {
            headerStackView.addArrangedSubview($0)
        }
        
        [headerStackView, hourlyContainer, dailyContainer].forEach {
            contentView.addSubview($0)
        }
        
        hourlyContainer.contentView.addSubview(collectionView)
        dailyContainer.contentView.addSubview(tableView)
    }
    
    private func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview() }
        
        scrollView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        cityLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(cityLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        conditionLabel.snp.makeConstraints { make in
            make.top.equalTo(tempLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
        }
        
        tempRangeLabel.snp.makeConstraints { make in
            make.top.equalTo(conditionLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
        }
        
        headerStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        hourlyContainer.snp.makeConstraints { make in
            make.top.equalTo(tempRangeLabel.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(150)
        }
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
        
        dailyContainer.snp.makeConstraints { make in
            make.top.equalTo(hourlyContainer.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-40)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-8)
            make.height.equalTo(168)
        }
        
        loader.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(60)
        }
    }
}

#Preview {
    MainView().showLivePreview()
}
