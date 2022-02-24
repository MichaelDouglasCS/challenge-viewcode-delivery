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

final class HomeView: UIView {

    private var restaurants: [Restaurant] = []

    private lazy var tableView: UITableView = {

        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RestaurantCellView.self, forCellReuseIdentifier: RestaurantCellView.cellIdentifier)
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

    func updateView(with restaurants: [Restaurant]) {

        self.restaurants = restaurants
        self.tableView.reloadData()
    }
    
    func updateLoading(with isLoading: Bool) {
        loadingView.updateLoading(isLoading)
    }
}

private extension HomeView {

    func setupViews() {
        self.backgroundColor = .white

        self.configureSubviews()
        self.configureSubviewsConstraints()
    }

    func configureSubviews() {
        self.addSubview(self.tableView)
        self.addSubview(self.loadingView)
    }

    func configureSubviewsConstraints() {
        configureLoadingViewConstraints()
        configureTableViewConstraints()
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

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.restaurants.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let restaurantCell = tableView.dequeueReusableCell(withIdentifier: RestaurantCellView.cellIdentifier, for: indexPath) as? RestaurantCellView else {
            return .init()
        }

        restaurantCell.configure(
            with: .init(
                name: "Percoriro Trattoria",
                detail: "Italiana • 38-48 min",
                icon: "restaurant-logo"
            )
        )

        return restaurantCell
    }
}

extension UITableViewCell {

    static var cellIdentifier: String {
        String(describing: self)
    }
}



