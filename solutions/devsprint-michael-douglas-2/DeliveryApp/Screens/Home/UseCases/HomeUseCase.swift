//
//  HomeUseCase.swift
//  DeliveryApp
//
//  Created by Michael Douglas on 25/02/22.
//

import Foundation

enum HomeUseCase {

    enum GetRestaurants {

        enum ViewModel {
            case loading
            case content([RestaurantCellViewModel])
            case error(String)
        }
    }
}
