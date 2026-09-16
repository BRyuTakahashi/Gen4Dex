//
//  PokedexProjectUITests.swift
//  PokedexProjectUITests
//
//  Created by Bruno Ryu Takahashi on 15/09/26.
//

import XCTest
@testable import PokedexProject

final class ServiceManagerTest: XCTestCase {
    
    var homeService: HomeService!

    override func setUpWithError() throws {
        homeService = HomeService()
    }

    override func tearDownWithError() throws {
        homeService = nil
    }

    func testFetchPokemonListSuccess() {
        homeService.fetchPokemonList { result in
            switch result {
            case .success(let success):
                XCTAssertNotNil(success, "Success não pode ser nil")
                XCTAssertGreaterThan(success.count, 0, "Deve retornar 1 ou mais pokemons")
            case .failure:
                XCTFail("Não pode cair em fail")
            }
        }
    }

    func testFetchPokemonFailure() {
        
    }

}
