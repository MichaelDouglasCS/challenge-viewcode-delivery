//
//  HomeView.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 31/10/21.
//

import UIKit

struct HomeViewConfiguration {
    let restaurants: [String]
}

protocol HomeViewProtocol: UIView {
    func updateState(state: HomeUseCase.GetRestaurants.ViewModel)
}

final class HomeView: UIView, HomeViewProtocol {

    private var categories: [Category] = [
        .init(title: "Pizza", image: "pizza"),
        .init(title: "Pizza", image: "pizza"),
        .init(title: "Pizza", image: "pizza"),
        .init(title: "Pizza", image: "pizza"),
        .init(title: "Pizza", image: "pizza"),
        .init(title: "Pizza", image: "pizza"),
        .init(title: "Pizza", image: "pizza"),
        .init(title: "Pizza", image: "pizza"),
        .init(title: "Pizza", image: "pizza"),
        .init(title: "Pizza", image: "pizza"),
        .init(title: "Pizza", image: "pizza"),
        .init(title: "Pizza", image: "pizza")
    ]

    private var restaurants: [RestaurantCellViewModel] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RestaurantCellView.self, forCellReuseIdentifier: RestaurantCellView.cellIdentifier)
        tableView.register(CategoryCarouselCellView.self, forCellReuseIdentifier: CategoryCarouselCellView.cellIdentifier)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var loadingView: LoadingView = {
        let loadingView = LoadingView()
        loadingView.setLoadingMessage("Carregando Restaurantes...")
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.isHidden = true
        return loadingView
    }()
    
    init() {
        super.init(frame: .zero)
        
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateState(state: HomeUseCase.GetRestaurants.ViewModel) {

        switch state {
        case .loading:
            loadingView.updateLoading(true)
        case .content(let restaurants):
            loadingView.updateLoading(false)
            self.restaurants = restaurants
            self.tableView.reloadData()
        case .error:
            loadingView.updateLoading(false)
            break
        }
    }
}

private extension HomeView {
    
    func setupViews() {
        
        self.backgroundColor = .white
        
        self.configureSubviews()
        self.configureLoadingViewConstraints()
        self.configureTableViewConstraints()
        
    }
    
    func configureSubviews() {
        
        self.addSubview(self.tableView)
        self.addSubview(self.loadingView)
    }
    
    func configureLoadingViewConstraints() {
        NSLayoutConstraint.activate([
            self.loadingView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            self.loadingView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            self.loadingView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            self.loadingView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    func configureTableViewConstraints() {
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension HomeView: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return self.restaurants.count
        default:
            return .zero
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCarouselCellView.cellIdentifier, for: indexPath) as? CategoryCarouselCellView else {
                return .init()
            }

            cell.configure(with: .init(categories: categories))

            return cell
        case 1:
            let restaurant = restaurants[indexPath.row]

            guard let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantCellView.cellIdentifier, for: indexPath) as? RestaurantCellView else {
                return .init()
            }

            cell.configure(with: .init(
                name: restaurant.name,
                detail: restaurant.detail,
                icon: "restaurant-logo")
            )

            return cell
        default:
            return .init()
        }
    }
}



