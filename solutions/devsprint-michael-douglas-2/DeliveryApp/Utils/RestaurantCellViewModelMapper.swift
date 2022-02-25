//
//  RestaurantCellViewModelMapper.swift
//  DeliveryApp
//
//  Created by Michael Douglas on 25/02/22.
//

import Foundation

protocol RestaurantCellViewModelMapperProtocol {
    func formattedRestaurantInfo(category: String, minDeliveryTime: Int, maxDeliveryTime: Int) -> String
}

class RestaurantCellViewModelMapper: RestaurantCellViewModelMapperProtocol {

    func formattedRestaurantInfo(category: String, minDeliveryTime: Int, maxDeliveryTime: Int) -> String {
        "\(category) • \(minDeliveryTime)-\(minDeliveryTime) min"
    }
}
