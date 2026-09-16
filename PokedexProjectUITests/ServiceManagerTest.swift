//
//  PokedexProjectUITests.swift
//  PokedexProjectUITests
//
//  Created by Bruno Ryu Takahashi on 15/09/26.
//

import XCTest
@testable import PokedexProject

final class ServiceManagerTest: XCTestCase {
    
    var serviceManager: ServiceManager!

    override func setUpWithError() throws {
        serviceManager = ServiceManager()
    }

    override func tearDownWithError() throws {
        serviceManager = nil
    }

    func testExample() {
        
    }


}
