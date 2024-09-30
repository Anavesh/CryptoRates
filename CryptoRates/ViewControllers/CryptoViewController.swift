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
        return view
    }()
    
    let rankLabel: UILabel = {
        let label = UILabel()
        label.text = "Default text"
        label.textColor = .black
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name:"Montserrat", size: 14)
        return label
    }()
    
    let logoImage: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(systemName: "questionMark")
        logo.contentMode = .scaleAspectFit
        return logo
    }()
    
    let maxSupplyLabel: UILabel = {
        let label = UILabel()
        label.text = "Default text"
        label.textColor = .black
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Montserrat", size: 14)
        return label
    }()
    
    private lazy var stackView: UIStackView = { // UIStackView must always be lazy var, cause it cant be guaranteed that all properties inside stackView will be initialized before the stackView
        let stack = UIStackView(arrangedSubviews: [rankLabel, logoImage, maxSupplyLabel])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 12
        return stack
    }()
    
    init(cryptoViewModel: CryptoViewModel, coin: Coin) {
        self.cryptoViewModel = cryptoViewModel
        super.init(nibName:nil, bundle:nil)
    }
    required init(coder: NSCoder) {
        fatalError("init(coder:) was not implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    // MARK: Setup of label values from CryptoViewModel
        
    // MARK: Setup UI
    
    func setView() {
        [contentView, scrollView].forEach {$0.translatesAutoresizingMaskIntoConstraints = false; view.addSubview($0)}
        contentView.addSubview(stackView)
    }
    
    func setConstraints() {
        
    }
}
