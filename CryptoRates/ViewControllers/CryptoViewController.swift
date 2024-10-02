import Foundation
import UIKit

class CryptoViewController: UIViewController {
    
    // MARK: Variables
    let cryptoViewModel:CryptoViewModel
    
    
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
        label.font = UIFont(name: "Avenir Bold", size: 28)
        label.adjustsFontSizeToFitWidth = false
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
        label.font = UIFont(name: "Avenir Bold", size: 28)
        label.adjustsFontSizeToFitWidth = false
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "Default text"
        label.textColor = .black
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Avenir Bold", size: 28)
        label.adjustsFontSizeToFitWidth = false
        return label
    }()
    
    let marketCapLabel: UILabel = {
        let label = UILabel()
        label.text = "Default text"
        label.textColor = .black
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Avenir Bold", size: 28)
        label.adjustsFontSizeToFitWidth = false
        return label
    }()
    
    private lazy var stackView: UIStackView = { // UIStackView must always be lazy var, cause it cant be guaranteed that all properties inside stackView will be initialized before the stackView
        let stack = UIStackView(arrangedSubviews: [logoImage, rankLabel, maxSupplyLabel,marketCapLabel,priceLabel])
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .fill
        return stack
    }()
    
    init(cryptoViewModel: CryptoViewModel) { // its custom initialisator, due to the fact that CryptoViewController is a daugther class of UIViewController which is parent class, we must also adress the initialisator of parent class
        self.cryptoViewModel = cryptoViewModel
        super.init(nibName: nil, bundle: nil) // initialisator for UIViewController, due to the fact that we want to write the UIViewController ourself nibname is nil, bundle is nil as well.
    }
    required init(coder: NSCoder) {
        fatalError("init(coder:) was not implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraints()
        view.backgroundColor = .systemBackground
        navigationItem.title = cryptoViewModel.coin.name
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: nil, action: nil)
        
        // MARK: Setup of label values from CryptoViewModel
        
        rankLabel.text = cryptoViewModel.rank
        maxSupplyLabel.text = cryptoViewModel.maxSupply
        priceLabel.text = cryptoViewModel.price
        marketCapLabel.text = cryptoViewModel.marketCap
    }
    
    // MARK: Setup UI
    
    func setView() {
        [contentView,scrollView,stackView].forEach {$0.translatesAutoresizingMaskIntoConstraints = false}
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
    }
    
    func setConstraints() {
        let height = contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20)
        height.priority = UILayoutPriority(1)
        height.isActive = true
        
        NSLayoutConstraint.activate([
            // Ограничения для scrollView
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            // Ограничения для contentView внутри scrollView
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1.0), // Делаем contentView такой же ширины, как и scrollView
            contentView.heightAnchor.constraint(equalTo:scrollView.heightAnchor),
            
            // Ограничения для stackView внутри contentView
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1.0), // Ограничиваем ширину stackView относительно contentView
        ])
    }
}
