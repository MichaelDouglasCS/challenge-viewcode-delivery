//
//  RestaurantCellViewModel+Fixture.swift
//  DeliveryAppTests
//
//  Created by Michael Douglas on 24/02/22.
//

import Foundation
@testable import DeliveryApp

extension RestaurantCellViewModel {

    static func fixture(
        name: String = "Abelha Gulosa",
        detail: String = "Padaria - 30 minutos",
        icon: String = "restaurant-logo"
    ) -> RestaurantCellViewModel {
        .init(name: name, detail: detail, icon: icon)
    }
}
