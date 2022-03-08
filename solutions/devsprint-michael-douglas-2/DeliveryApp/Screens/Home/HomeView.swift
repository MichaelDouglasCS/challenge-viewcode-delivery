//
//  HomeView.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 31/10/21.
//

import UIKit
import SnapKit

struct HomeViewConfiguration {
    let restaurants: [String]
}

protocol HomeViewProtocol: UIView {
    var delegate: HomeViewDelegate? { get set }

    func updateState(state: HomeUseCase.GetRestaurants.ViewModel)
}

protocol HomeViewDelegate: AnyObject {
    func didSelectContent()
}

final class HomeView: UIView, HomeViewProtocol {

    // MARK: - MOCK

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

    // MARK: - View Properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(RestaurantCellView.self, forCellReuseIdentifier: RestaurantCellView.cellIdentifier)
        tableView.register(CategoryCarouselCellView.self, forCellReuseIdentifier: CategoryCarouselCellView.cellIdentifier)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var loadingView: LoadingView = {
        let loadingView = LoadingView()
        loadingView.setLoadingMessage("Carregando Restaurantes...")
        loadingView.isHidden = true
        return loadingView
    }()
    
    private lazy var addressView: AddressView = {
        let view = AddressView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var dividerView: DividerView = {
        let view = DividerView()
        return view
    }()

    // MARK: - Internal Properties

    weak var delegate: HomeViewDelegate?

    // MARK: - Private Properties

    private var restaurants: [RestaurantCellViewModel] = []

    // MARK: - Initiliazers
    
    init() {
        super.init(frame: .zero)
        
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Internal Methods

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
        self.configureAddressViewConstraints()
        self.configureDividerViewConstraints()
        self.configureTableViewConstraints()
        
    }
    
    func configureSubviews() {
        
        self.addSubview(self.addressView)
        self.addSubview(self.dividerView)
        self.addSubview(self.tableView)
        self.addSubview(self.loadingView)
    }
    
    func configureLoadingViewConstraints() {
//        NSLayoutConstraint.activate([
//            self.loadingView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
//            self.loadingView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
//            self.loadingView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
//            self.loadingView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
//        ])

        loadingView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    func configureAddressViewConstraints() {
//        NSLayoutConstraint.activate([
//            self.addressView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
//            self.addressView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            self.addressView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
//            self.addressView.heightAnchor.constraint(equalToConstant: 66)
//        ])

        addressView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(66)
        }
    }
    
    func configureDividerViewConstraints() {
//        NSLayoutConstraint.activate([
//            self.dividerView.topAnchor.constraint(equalTo: self.addressView.bottomAnchor, constant: 8),
//            self.dividerView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
//            self.dividerView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
//        ])

        dividerView.snp.makeConstraints { make in
            make.top.equalTo(addressView.snp.bottom).offset(8)
            make.leading.equalTo(safeAreaLayoutGuide)
            make.trailing.equalTo(safeAreaLayoutGuide)
        }
    }
    
    func configureTableViewConstraints() {
//        NSLayoutConstraint.activate([
//            self.tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
//            self.tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
//            self.tableView.topAnchor.constraint(equalTo: self.dividerView.bottomAnchor, constant: 10),
//            self.tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
//        ])

        tableView.snp.makeConstraints { make in
            make.top.equalTo(dividerView).offset(10)
            make.leading.equalTo(safeAreaLayoutGuide)
            make.trailing.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}

// MARK: - UITableViewDataSource

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

// MARK: - UITableViewDelegate

extension HomeView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectContent()
    }
}
