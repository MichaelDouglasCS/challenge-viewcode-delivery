//
//  HomeViewControllerTests.swift
//  DeliveryAppTests
//
//  Created by Michael Douglas on 23/02/22.
//

import Foundation
import UIKit
@testable import DeliveryApp
import XCTest

final class HomeViewControllerTests: XCTestCase {

    let deliveryApiSpy = DeliveryApiSpy()
    
    lazy var sut: HomeViewController = {
        let sut = HomeViewController(deliveryApi: deliveryApiSpy)
        let navigationController = UINavigationController(rootViewController: sut)
        return sut
    }()

    func test_viewDidLoad_shouldSetPreferLargeTitlesTrue() {
        sut.loadView()
        sut.viewDidLoad()

        XCTAssertTrue(sut.navigationController?.navigationBar.prefersLargeTitles == true)
    }

    func test_viewDidLoad_whenFetchRestaurants_shouldSucceed() {
        sut.loadView()
        sut.viewDidLoad()

        XCTAssertTrue(deliveryApiSpy.fetchRestaurantsBeCalled)
    }
}

class DeliveryApiSpy: DeliveryApiProtocol {

    private(set) var fetchRestaurantsBeCalled: Bool = false
    func fetchRestaurants(_ completion: @escaping ([Restaurant]?) -> Void) {
        fetchRestaurantsBeCalled = true
    }

    private(set) var searchAddressesBeCalled: Bool = false
    func searchAddresses(_ completion: @escaping ([Address]?) -> Void) {
        searchAddressesBeCalled = true
    }

    private(set) var fetchRestaurantDetailsBeCalled: Bool = false
    func fetchRestaurantDetails(_ completion: @escaping (RestaurantDetails?) -> Void) {
        fetchRestaurantDetailsBeCalled = true
    }
}

