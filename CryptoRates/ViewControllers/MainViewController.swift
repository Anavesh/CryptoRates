import UIKit

class MainViewController: UIViewController {
    
    // MARK: Variables
    
    let coins: [Coin] = [
        Coin(name: "BitCoin", id: 1, cmcRank: 1, maxSupply: 1000, pricingData: PricingData(price: 10000, marketCap: 2000)),
        Coin(name: "Ethereum", id: 2, cmcRank: 2, maxSupply: 5000, pricingData: PricingData(price: 5000, marketCap: 1000)),
        Coin(name: "Flycoin", id: 3, cmcRank: 3, maxSupply: nil, pricingData: PricingData(price: 1000, marketCap: 500)),
        Coin(name: "LiteCoin", id: 4, cmcRank: 4, maxSupply: 8400, pricingData: PricingData(price: 2000, marketCap: 800)),
        Coin(name: "Ripple", id: 5, cmcRank: 5, maxSupply: 100000, pricingData: PricingData(price: 0.6, marketCap: 600)),
        Coin(name: "Dogecoin", id: 6, cmcRank: 6, maxSupply: nil, pricingData: PricingData(price: 0.2, marketCap: 50)),
        Coin(name: "Cardano", id: 7, cmcRank: 7, maxSupply: 45000, pricingData: PricingData(price: 2.0, marketCap: 900)),
        Coin(name: "Polkadot", id: 8, cmcRank: 8, maxSupply: 10000, pricingData: PricingData(price: 25.0, marketCap: 1000)),
        Coin(name: "Binance Coin", id: 9, cmcRank: 9, maxSupply: 17000, pricingData: PricingData(price: 350.0, marketCap: 6000)),
        Coin(name: "Chainlink", id: 10, cmcRank: 10, maxSupply: 1000, pricingData: PricingData(price: 30.0, marketCap: 1500)),
        Coin(name: "Uniswap", id: 11, cmcRank: 11, maxSupply: 1000, pricingData: PricingData(price: 28.0, marketCap: 1400)),
        Coin(name: "Solana", id: 12, cmcRank: 12, maxSupply: nil, pricingData: PricingData(price: 140.0, marketCap: 7000)),
        Coin(name: "Stellar", id: 13, cmcRank: 13, maxSupply: 50000, pricingData: PricingData(price: 0.4, marketCap: 500)),
        Coin(name: "VeChain", id: 14, cmcRank: 14, maxSupply: 86000, pricingData: PricingData(price: 0.12, marketCap: 100)),
        Coin(name: "Aave", id: 15, cmcRank: 15, maxSupply: 16000, pricingData: PricingData(price: 400.0, marketCap: 3200)),
        Coin(name: "Theta", id: 16, cmcRank: 16, maxSupply: 1000, pricingData: PricingData(price: 6.0, marketCap: 600)),
        Coin(name: "Avalanche", id: 17, cmcRank: 17, maxSupply: 10000, pricingData: PricingData(price: 60.0, marketCap: 2000)),
        Coin(name: "Cosmos", id: 18, cmcRank: 18, maxSupply: nil, pricingData: PricingData(price: 30.0, marketCap: 900)),
    ]
    
    // MARK: UI elements
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraints()
        setupTableView()
        navigationItem.title = "List of currencies"
    }
    
    // MARK: Setup UI

   private func setView() {
        view.addSubview(tableView)
    }
    
   private func setConstraints() {
       
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: Setup TableView
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CoinCell.self, forCellReuseIdentifier: CoinCell.identifier) // регистрация ячейки типа CoinCell, в данном случае .self обозначает не экземпляр класса, а тип данных (то есть класс). В качестве индентификатора используем значение статической переменной identifier, класса CoinCell. Это поможет при необходимости изменив значение статической переменной изменить индентификтор сразу по всему коду.
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinCell.identifier, for: indexPath) as? CoinCell else {return UITableViewCell()}
        let coin = coins[indexPath.row] // Извлекаем текущий объект массива coins для текущей строки таблицы для того, чтобы потом использовать этот объект для настройки ячейки
        cell.configureCell(with: coin)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath:IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coin = coins[indexPath.row]
        let viewModel = CryptoViewModel(coin: coin)
        let viewController = CryptoViewController(cryptoViewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
