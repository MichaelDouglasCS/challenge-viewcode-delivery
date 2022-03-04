//
//  ViewController.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 25/10/21.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Private Properties

    private let deliveryApi: DeliveryApiProtocol
    private let restaurantMapper: RestaurantCellViewModelMapperProtocol
    private let homeView: HomeViewProtocol

    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Nome do restaurante"
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()

    // MARK: - Initializers

    init(
        customView: HomeViewProtocol = HomeView(),
        deliveryApi: DeliveryApiProtocol = DeliveryApi(),
        restaurantMapper: RestaurantCellViewModelMapperProtocol = RestaurantCellViewModelMapper()
    ) {
        self.homeView = customView
        self.deliveryApi = deliveryApi
        self.restaurantMapper = restaurantMapper
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = "Delivery App"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Internal Methods

    override func loadView() {
        self.view = homeView
        homeView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        fetchRestaurants()
    }
    
    // MARK: - Private Methods

    private func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.title = "Delivery App"
    }

    private func fetchRestaurants() {
        homeView.updateState(state: .loading)

        deliveryApi.fetchRestaurants { [weak self] response in
            guard let self = self else { return }

            switch response {
            case .success(let restaurants):
                let viewModels: [RestaurantCellViewModel] = restaurants.map {

                    let detail = self.restaurantMapper.formattedRestaurantInfo(
                        category: $0.category,
                        minDeliveryTime: $0.deliveryTime.min,
                        maxDeliveryTime: $0.deliveryTime.max
                    )

                    return .init(name: $0.name, detail: detail, icon: $0.icon)
                }

                DispatchQueue.main.async {
                    self.homeView.updateState(state: .content(viewModels))
                }
            case .failure(let error):
                self.homeView.updateState(state: .error(error.localizedDescription))
            }
        }
    }
}

extension HomeViewController: UISearchBarDelegate {

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
}

extension HomeViewController: HomeViewDelegate {

    func didSelectContent() {
        let detailsViewController = RestaurantDetailsViewController()
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
