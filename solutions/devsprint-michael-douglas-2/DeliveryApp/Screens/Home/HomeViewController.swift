//
//  ViewController.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 25/10/21.
//

import UIKit

class HomeViewController: UIViewController {

    private var deliveryApi: DeliveryApiProtocol

    private let homeView: HomeView = {

        let homeView = HomeView()
        return homeView
    }()

    init(deliveryApi: DeliveryApiProtocol = DeliveryApi()) {
        self.deliveryApi = deliveryApi
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = "Delivery App"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        homeView.updateLoading(with: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        
        deliveryApi.fetchRestaurants { restaurants in
            guard let restaurants = restaurants else {
                return
            }
            DispatchQueue.main.async {
                self.homeView.updateView(with: restaurants)
                self.homeView.updateLoading(with: false)
            }
        }
    }
    
    override func loadView() {
        self.view = homeView
    }
}
