import UIKit
import Kingfisher

class CryptoViewController: UIViewController {
    
    // MARK: Variables
    let cryptoViewModel: CryptoViewControllerViewModel
    
    // MARK: UI elements
    let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = true
        return view
    }()
    
    let rankLabel: UILabel = {
        let label = UILabel()
        label.text = "Default text"
        label.textColor = .black
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    let logoImage: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(systemName: "questionmark")
        logo.contentMode = .scaleAspectFit
        return logo
    }()
    
    let maxSupplyLabel: UILabel = {
        let label = UILabel()
        label.text = "Default text"
        label.textColor = .black
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    let totalSupplyLabel: UILabel = {
        let label = UILabel()
        label.text = "Default text"
        label.textColor = .black
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    let circulatingSupplyLabel: UILabel = {
        let label = UILabel()
        label.text = "Default text"
        label.textColor = .black
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "Default text"
        label.textColor = .black
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    let marketCapLabel: UILabel = {
        let label = UILabel()
        label.text = "Default text"
        label.textColor = .black
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.adjustsFontForContentSizeCategory = true 
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [logoImage, rankLabel, maxSupplyLabel,totalSupplyLabel, circulatingSupplyLabel, marketCapLabel, priceLabel])
        stack.axis = .vertical
        stack.spacing = 12
        stack.alignment = .center
        return stack
    }()
    
    init(cryptoViewModel: CryptoViewControllerViewModel) {
        self.cryptoViewModel = cryptoViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) was not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraints()
        setCoinLogoImage()
        setNavigationBar()
        setLabelsText()
    }
    
    func setNavigationBar() {
        navigationItem.title = cryptoViewModel.coin.name
    }
    
    func setLabelsText() {
        rankLabel.text = cryptoViewModel.rank
        maxSupplyLabel.text = cryptoViewModel.maxSupply
        priceLabel.text = cryptoViewModel.price
        marketCapLabel.text = cryptoViewModel.marketCap
        circulatingSupplyLabel.text = cryptoViewModel.circulatingSupply
        totalSupplyLabel.text = cryptoViewModel.totalSupply
    }
    
    func setCoinLogoImage() {
        logoImage.kf.setImage(with: cryptoViewModel.coin.logoURL)
    }
        
    func setView() {
        [contentView, scrollView, stackView].forEach {$0.translatesAutoresizingMaskIntoConstraints = false}
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        view.backgroundColor = .systemBackground
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate ([
            // Constraints for scrollView
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            // Constraints for contentView inside scrollView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Constraints for stackView inside contentView
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20),
            stackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),
            
            // Constraints for logoImage size
            logoImage.heightAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.3),
            logoImage.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.3)
        ])
    }
}
