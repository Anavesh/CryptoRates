import UIKit

class MainViewController: UIViewController, UISearchControllerDelegate {
    
    // MARK: Variables
    
    private let viewModel: MainViewControllerViewModel
    
    // MARK: UI elements
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(viewModel:MainViewControllerViewModel = MainViewControllerViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraints()
        setupTableView()
        setupNavigationBar()
        reloadTableView()
        setupSearchController()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Скрываем клавиатуру, если она открыта
        searchController.searchBar.resignFirstResponder()
    }
    
    // MARK: Setup UI
    
    
   private func reloadTableView() {
        self.viewModel.onCoinsUpdated = {[weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

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
        tableView.register(CoinCell.self, forCellReuseIdentifier: CoinCell.identifier)
    }
    
    // MARK: Setup NavigationBar titles
    
    func setupNavigationBar() {
        navigationItem.title = "List of currencies"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: nil, action: nil)
    }
    
    // MARK: Setup SearchController
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Cryptos"
        
        navigationItem.searchController = searchController
        definesPresentationContext = false
        navigationItem.hidesSearchBarWhenScrolling = false
        self.searchController.delegate = self
        searchController.searchBar.showsCancelButton = true
        searchController.searchBar.showsBookmarkButton = true
        searchController.searchBar.setImage(UIImage(systemName: "questionmark"), for: .bookmark, state: .normal)
     }
}

    // MARK: Setup SearchController functions

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print("DEBUG PRINT:", searchController.searchBar.text)
        viewModel.updateSearchController(searchBarText:searchController.searchBar.text)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        let inSearchMode = viewModel.inSearchMode(searchController)
        return inSearchMode ? viewModel.filteredCoins.count : viewModel.allCoins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinCell.identifier, for: indexPath) as? CoinCell else { fatalError("Unable to dequeue CoinCell in HomeController")}
        let inSearchMode = viewModel.inSearchMode(searchController)
        let coin = inSearchMode ? viewModel.filteredCoins[indexPath.row] : viewModel.allCoins[indexPath.row]
        cell.configure(with:coin)
        cell.updateImage()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath:IndexPath) -> CGFloat {
        return 64
    }
    
    // Method to push to CryptoViewController
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let inSearchMode = viewModel.inSearchMode(searchController)
        let coin = inSearchMode ? viewModel.filteredCoins[indexPath.row] : viewModel.allCoins[indexPath.row]
        let viewModel = CryptoViewControllerViewModel(coin: coin)
        let viewController = CryptoViewController(cryptoViewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
