//
//  TableViewBuilderTests.swift
//  TomorrowTests
//
//  Created by Михаил Ластовкин on 26.04.2022.
//

import XCTest
@testable import Завтра_в_лагерь

class TableViewBuilderTests: XCTestCase {

    var sut: TableViewBuilder?

    override func setUp() {
        super.setUp()
        sut = TableViewBuilder()
    }

    override func tearDown(){
        sut = nil
       super.tearDown()
    }

    func testInitTableViewBuilder() {
        XCTAssertNotNil(sut)
    }

    func testGetTableViewFromTableViewBuilder() {
        let tableView = sut?.buildTableView(with: .activity)
        XCTAssertNotNil(tableView)
    }

}
