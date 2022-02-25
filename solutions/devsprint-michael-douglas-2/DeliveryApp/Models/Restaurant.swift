//
//  Restaurant.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 04/02/22.
//

import Foundation

struct Restaurant: Decodable {
    let name: String
    let category: String
    let deliveryTime: DeliveryTime
    let icon: String = "restaurant-logo"
}

struct DeliveryTime: Decodable {
    let min: Int
    let max: Int
}
