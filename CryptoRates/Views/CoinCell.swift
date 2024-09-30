import UIKit

class CoinCell: UITableViewCell {
    
    //MARK: Variables
    
    static var identifier = "CoinCell"
    private var coin: Coin?
    
    // MARK: UI Elements
    
    let coinName:UILabel = {
        let label = UILabel()
        label.text = "No text at all"
        label.textColor = .black
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let coinLogo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(systemName:"arrow.uturn.up")
        logo.tintColor = .label
        logo.contentMode = .scaleAspectFit
        return logo
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        setView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Function to setup the cell content with coin data
    
    public func configureCell(with coin: Coin) {
        self.coin = coin
        self.coinName.text = coin.name
    }
    
    
    // MARK: Setup UI
    private func setView() {
        [coinName, coinLogo].forEach {$0.translatesAutoresizingMaskIntoConstraints = false; self.addSubview($0)}
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            coinLogo.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            coinLogo.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.75),
            coinLogo.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.75),
            
            coinName.leadingAnchor.constraint(equalTo: coinLogo.trailingAnchor, constant: 16),
            coinName.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
}
