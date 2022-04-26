//
//  MainMenuItemTests.swift
//  TomorrowTests
//
//  Created by Михаил Ластовкин on 26.04.2022.
//

import XCTest
@testable import Завтра_в_лагерь

class MainMenuItemTests: XCTestCase {

    

    func testInitMainMenuItem() {
        let mainMenuItem = MainMenuItem(title: "foo", subTitle: "bar", imageName: "img", articleCategory: .activity)

        XCTAssertNotNil(mainMenuItem)
    }

    func testWhenGivenDataGetMainMenuItem() {
        let mainMenuItem = MainMenuItem(title: "foo", subTitle: "bar", imageName: "img", articleCategory: .activity)

        XCTAssertEqual(mainMenuItem.title, "foo")
        XCTAssertEqual(mainMenuItem.subTitle, "bar")
        XCTAssertEqual(mainMenuItem.imageName, "img")
        XCTAssertEqual(mainMenuItem.articleCategory, .activity)
    }

}
