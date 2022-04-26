//
//  TableViewPresenterTests.swift
//  TomorrowTests
//
//  Created by Михаил Ластовкин on 26.04.2022.
//

import XCTest

@testable import Завтра_в_лагерь

class TableViewPresenterTests: XCTestCase {

    var sut: TableViewPresenter?

    override func setUp() {
        super.setUp()
        sut = TableViewPresenter(articleCategory: .activity)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}
