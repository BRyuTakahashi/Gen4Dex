//
//  HomeViewModelTest.swift
//  PokedexProjectUITests
//
//  Created by Bruno Ryu Takahashi on 06/10/26.
//

import XCTest
@testable import PokedexProject

final class HomeViewModelTest: XCTestCase {
    
    var mockDelegate: MockDelegate!
    var mockURLSession: MockURLSession!
    var homeViewModel: HomeViewModel!
    var homeService: HomeService!
    var serviceManager: ServiceManager!
    
    override func setUpWithError() throws {
        mockDelegate = MockDelegate()
        mockURLSession = MockURLSession()
        serviceManager = ServiceManager(session: mockURLSession)
        homeService = HomeService(serviceManager: serviceManager)
        homeViewModel = HomeViewModel(homeService: homeService)
        homeViewModel.delegate(delegate: mockDelegate)
    }

    override func tearDownWithError() throws {
        mockDelegate = nil
        mockURLSession = nil
        homeViewModel = nil
        homeService = nil
        serviceManager = nil
    }

    func testFetchPokemonSuccess() {
        let json = """
        {
            "results": [
                {"name": "turtwig", "url": "https://pokeapi.co/api/v2/pokemon/387"}
            ]
        }
        """.data(using: .utf8)
        
        let pokemonDetail = """
        {
            "id": 387,
            "name": "turtwig",
            "types": [
                {
                    "type": {
                        "name": "grass"
                    }
                }
            ],
            "sprites": {
                "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/387.png",
                "other": {
                    "official-artwork": {
                        "front-default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/387.png"
                    }
                }
            },
            "stats": [
                {
                    "base_stat": 55,
                    "effort": 0,
                    "stat": {
                        "name": "hp"
                    }
                },
                {
                    "base_stat": 68,
                    "effort": 1,
                    "stat": {
                        "name": "attack"
                    }
                },
                {
                    "base_stat": 64,
                    "effort": 0,
                    "stat": {
                        "name": "defense"
                    }
                },
                {
                    "base_stat": 45,
                    "effort": 0,
                    "stat": {
                        "name": "special-attack"
                    }
                },
                {
                    "base_stat": 55,
                    "effort": 0,
                    "stat": {
                        "name": "special-defense"
                    }
                },
                {
                    "base_stat": 31,
                    "effort": 0,
                    "stat": {
                        "name": "speed"
                    }
                }
            ],
            "weight": 102,
            "height": 4
        }
        """.data(using: .utf8)
        
        mockURLSession.listData = json
        mockURLSession.detailData = pokemonDetail
        
        mockURLSession.response = HTTPURLResponse(
            url: URL(string: "https://pokeapi.co")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        homeViewModel.delegate(delegate: mockDelegate)
        
        homeViewModel.fetchPokemon()
        
        XCTAssert(mockDelegate.successCalled, "Must return true")
        XCTAssertEqual(homeViewModel.getPokemonList().count, 1)
    }

}

class MockDelegate: HomeViewModelProtocol {
    var successCalled = false
    var failureCalled = false
    
    func success() {
        successCalled = true
    }
    
    func failure() {
        failureCalled = true
    }
    
}
