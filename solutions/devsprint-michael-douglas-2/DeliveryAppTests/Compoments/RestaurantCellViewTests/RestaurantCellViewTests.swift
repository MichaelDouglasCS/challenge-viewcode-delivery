//
//  RestaurantCellViewTests.swift
//  DeliveryAppTests
//
//  Created by Michael Douglas on 23/02/22.
//

import Foundation
import XCTest
import SnapshotTesting
@testable import DeliveryApp

final class RestaurantCellViewTest: XCTestCase {

    var isRecord: Bool = false
    var snapshotSize: CGSize = .init(width: 300, height: 100)
    var sut = RestaurantCellView()

    func test_snapshot_whenAllInfo_shouldSucceed() {
        sut.configure(with: .init(name: "Abelha Gulosa", detail: "Padaria - 30 minutos", icon: "restaurant-logo"))

        assertSnapshot(matching: sut, as: .image(size: snapshotSize), record: isRecord)
    }

    func test_snapshot_whenOnlyName_shouldSucceed() {
        sut.configure(with: .init(name: "Abelha Gulosa", detail: "", icon: "restaurant-logo"))

        assertSnapshot(matching: sut, as: .image(size: snapshotSize), record: isRecord)
    }

    func test_snapshot_whenOnlyDetail_shouldSucceed() {
        sut.configure(with: .init(name: "", detail: "Padaria - 30 minutos", icon: "restaurant-logo"))

        assertSnapshot(matching: sut, as: .image(size: snapshotSize), record: isRecord)
    }

    func test_snapshot_whenIconEmpty_shouldSucceed() {
        sut.configure(with: .init(name: "Abelha Gulosa", detail: "Padaria - 30 minutos", icon: ""))

        assertSnapshot(matching: sut, as: .image(size: snapshotSize), record: isRecord)
    }

    func test_snapshot_whenLargeInfos_shouldSucceed() {
        sut.configure(with: .init(name: "Abelha Gulosa Abelha Gulosa Abelha Gulosa Abelha Gulosa Abelha Gulosa Abelha Gulosa", detail: "Padaria - 30 minutos Padaria - 30 minutos Padaria - 30 minutos Padaria - 30 minutos Padaria - 30 minutos Padaria - 30 minutos", icon: "restaurant-logo"))

        assertSnapshot(matching: sut, as: .image(size: snapshotSize), record: isRecord)
    }

    func test_snapshot_whenEmptyInfos_shouldSucceed() {
        sut.configure(with: .init(name: "", detail: "", icon: ""))

        assertSnapshot(matching: sut, as: .image(size: snapshotSize), record: isRecord)
    }
}


