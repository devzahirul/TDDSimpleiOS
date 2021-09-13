//
//  NewsModelTest.swift
//  TDDSimpleiOSTests
//
//  Created by Islam Md. Zahirul on 13/9/21.
//

import XCTest
@testable import TDDSimpleiOS

class NewsModelTest: XCTestCase {
    
    func testInitNewsModelNil() {
        let newsModel = makeSUT()
        XCTAssertEqual(newsModel.title, nil)
        XCTAssertEqual(newsModel.description, nil)
    }
    
    func testInitNewsModelEmpty() {
        let newsModel = makeSUT(title: "", description: "")
        XCTAssertEqual(newsModel.title, "")
        XCTAssertEqual(newsModel.description, "")
    }
    
    func testNewsModelWhenDescriptionNil() {
        let newsModel = makeSUT(title: "A news title", description: nil)
        XCTAssertEqual(newsModel.description, nil)
    }
    
    func testNewsModelWhenTitleNil() {
        let newsModel = makeSUT(title: nil, description: "A description")
        XCTAssertEqual(newsModel.title, nil)
    }
    
    func testNewsModelWhenTitleAndDescription() {
        let newsModel = makeSUT(title: "Title", description: "A description")
        XCTAssertEqual(newsModel.title, "Title")
        XCTAssertEqual(newsModel.description, "A description")
    }
    
    private func makeSUT(title: String? = nil, description: String? = nil) -> NewsModel {
        return NewsModel(title: title, description: description)
    }
}
