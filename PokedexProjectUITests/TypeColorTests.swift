//
//  TypeColorTests.swift
//  PokedexProjectUITests
//
//  Created by Bruno Ryu Takahashi on 29/09/26.
//

import XCTest
@testable import PokedexProject

final class TypeColorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        for type in TypeColor.allCases {
            XCTAssertNotNil(type.backgroundColor, "\(type.rawValue) has not background color")
        }
    }

}
