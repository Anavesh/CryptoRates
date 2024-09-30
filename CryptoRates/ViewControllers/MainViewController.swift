import UIKit

class MainViewController: UIViewController {
    
    // MARK: Variables
    
    let coins: [Coin] = [Coin(name: "BitCoin", id: 1, cmcRank: 1, maxSupply: 1000, pricingData: PricingData(price: 10000, marketCap: 2000)),
                         Coin(name: "Ethereum", id: 2, cmcRank: 2, maxSupply: 5000, pricingData: PricingData(price: 5000, marketCap: 1000)),
                         Coin(name: "Flycoin", id: 3, cmcRank: 3, maxSupply: nil, pricingData: PricingData(price: 1000, marketCap: 500))
    
    ]
    
    
    // MARK: UI elements
    
    let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setContsraints()
        setupTableView()
    }
    
    // MARK: Setup UI

   private func setView() {
        view.addSubview(tableView)
    }
    
   private func setContsraints() {
        NSLayoutConstraint.activate([
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor)
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
        
    }
    
}
