//
//  RestaurantDetailsView.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 03/11/21.
//

import UIKit

class RestaurantDetailsView: UIView {

    // MARK: - MOCK

    private var categories: [CategoryItem] = [
        .init(title: "Café da Manhã 1", items: ["Banana", "Coca Cola", "Pão de Queijo", "Coxinha"]),
        .init(title: "Café da Manhã 2", items: ["Banana", "Coca Cola", "Pão de Queijo", "Coxinha"]),
        .init(title: "Café da Manhã 3", items: ["Banana", "Coca Cola", "Pão de Queijo", "Coxinha"]),
        .init(title: "Café da Manhã 4", items: ["Banana", "Coca Cola", "Pão de Queijo", "Coxinha"]),
        .init(title: "Café da Manhã 5", items: ["Banana", "Coca Cola", "Pão de Queijo", "Coxinha"]),
        .init(title: "Café da Manhã 6", items: ["Banana", "Coca Cola", "Pão de Queijo", "Coxinha"]),
        .init(title: "Café da Manhã 7", items: ["Banana", "Coca Cola", "Pão de Queijo", "Coxinha"]),
        .init(title: "Café da Manhã 8", items: ["Banana", "Coca Cola", "Pão de Queijo", "Coxinha"]),
        .init(title: "Café da Manhã 9", items: ["Banana", "Coca Cola", "Pão de Queijo", "Coxinha"]),
        .init(title: "Café da Manhã 10", items: ["Banana", "Coca Cola", "Pão de Queijo", "Coxinha"])
    ]

    // MARK: - View Properties

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: - Private Methods

    private func setup() {
        backgroundColor = .white
        addSubview(tableView)

        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func updateView(with restaurantDetails: RestaurantDetails) {
        tableView.reloadData()
    }
}

extension RestaurantDetailsView: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        categories.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories[section].items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.cellIdentifier, for: indexPath)
        cell.textLabel?.textColor = .black
        cell.textLabel?.text = categories[indexPath.section].items[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        categories[section].title
    }
}

extension RestaurantDetailsView: UITableViewDelegate {

}

struct CategoryItem {
    var title: String
    var items: [String]
}
