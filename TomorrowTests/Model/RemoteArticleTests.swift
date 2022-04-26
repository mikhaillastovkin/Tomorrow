//
//  RemoteArticleTests.swift
//  TomorrowTests
//
//  Created by Михаил Ластовкин on 26.04.2022.
//

import XCTest
@testable import Завтра_в_лагерь

class RemoteArticleTests: XCTestCase {

    func testRemoteArticleInit() {
        let remoteArtikle = RemoteArticle(title: "foo", subtitle: "bar", category: 0, text: "text", imgName: "img", props: "baz", url: "box", sortTag: "tag")

        XCTAssertNotNil(remoteArtikle)
    }

    func testWhenGivenDataGetRemoteArticle() {
        let remoteArtikle = RemoteArticle(title: "foo", subtitle: "bar", category: 0, text: "text", imgName: "img", props: "baz", url: "box", sortTag: "tag")

        XCTAssertEqual(remoteArtikle.title, "foo")
        XCTAssertEqual(remoteArtikle.subtitle, "bar")
        XCTAssertEqual(remoteArtikle.category, 0)
        XCTAssertEqual(remoteArtikle.text, "text")
        XCTAssertEqual(remoteArtikle.imgName, "img")
        XCTAssertEqual(remoteArtikle.props, "baz")
        XCTAssertEqual(remoteArtikle.url, "box")
        XCTAssertEqual(remoteArtikle.sortTag, "tag")
    }
}
