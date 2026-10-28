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
        // ... configura os dados ...
        
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
            "types": [{"type": {"name": "grass"}}],
            "sprites": {
                "front_default": "https://...",
                "other": {"official-artwork": {"front_default": "https://..."}}
            },
            "stats": [
                {"base_stat": 55, "effort": 0, "stat": {"name": "hp"}},
                {"base_stat": 68, "effort": 1, "stat": {"name": "attack"}},
                {"base_stat": 64, "effort": 0, "stat": {"name": "defense"}},
                {"base_stat": 45, "effort": 0, "stat": {"name": "special-attack"}},
                {"base_stat": 55, "effort": 0, "stat": {"name": "special-defense"}},
                {"base_stat": 31, "effort": 0, "stat": {"name": "speed"}}
            ],
            "weight": 102,
            "height": 4
        }
        """.data(using: .utf8)

        mockURLSession.listData = json
        mockURLSession.detailDataByURL["pokemon/387"] = pokemonDetail
        mockURLSession.response = HTTPURLResponse(
            url: URL(string: "https://pokeapi.co")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        let expectation = expectation(description: "fetchPokemon success")
        
        // sobrescreve o delegate para também cumprir a expectation
        class MockDelegateWithExpectation: HomeViewModelProtocol {
            var expectation: XCTestExpectation
            var successCalled = false
            
            init(expectation: XCTestExpectation) {
                self.expectation = expectation
            }
            
            func success() {
                successCalled = true
                expectation.fulfill()
            }
            func failure() {
                expectation.fulfill()
            }
        }
        
        let delegateWithExp = MockDelegateWithExpectation(expectation: expectation)
        homeViewModel.delegate(delegate: delegateWithExp)
        
        homeViewModel.fetchPokemon()
        
        waitForExpectations(timeout: 1.0)
        
        XCTAssertTrue(delegateWithExp.successCalled)
        homeViewModel.filterSearchText("")
        XCTAssertEqual(homeViewModel.getPokemonList().count, 1)
    }
    
    func testFetchPokemonFailure() {
        mockURLSession.error = NSError(domain: "test", code: 404)
        
        class MockDelegateWithExpectation: HomeViewModelProtocol {
            var expectation: XCTestExpectation
            var successCalled = false
            var failureCalled = false
            
            init(expectation: XCTestExpectation) {
                self.expectation = expectation
            }
            
            func success() {
                successCalled = true
                expectation.fulfill()
            }
            func failure() {
                failureCalled = true
                expectation.fulfill()
            }
        }
        
        let expectation = expectation(description: "fetchPokemon failure")
        
        let delegateWithExp = MockDelegateWithExpectation(expectation: expectation)
        homeViewModel.delegate(delegate: delegateWithExp)
        
        homeViewModel.fetchPokemon()
        
        waitForExpectations(timeout: 1.0)
        
        XCTAssertFalse(delegateWithExp.successCalled)
        XCTAssertTrue(delegateWithExp.failureCalled)
        XCTAssertEqual(homeViewModel.numberOfItems(), 0)
    }
    
    func loadPokemon() {
        let json = """
        {
            "results": [
                {"name": "turtwig", "url": "https://pokeapi.co/api/v2/pokemon/387"},
                {"name": "chimchar", "url": "https://pokeapi.co/api/v2/pokemon/390"}
            ]
        }
        """.data(using: .utf8)

        let turtwigJSON = """
        {
            "id": 387,
            "name": "turtwig",
            "types": [{"type": {"name": "grass"}}],
            "sprites": {
                "front_default": "https://...",
                "other": {"official-artwork": {"front_default": "https://..."}}
            },
            "stats": [
                {"base_stat": 55, "effort": 0, "stat": {"name": "hp"}},
                {"base_stat": 68, "effort": 1, "stat": {"name": "attack"}},
                {"base_stat": 64, "effort": 0, "stat": {"name": "defense"}},
                {"base_stat": 45, "effort": 0, "stat": {"name": "special-attack"}},
                {"base_stat": 55, "effort": 0, "stat": {"name": "special-defense"}},
                {"base_stat": 31, "effort": 0, "stat": {"name": "speed"}}
            ],
            "weight": 102,
            "height": 4
        }
        """.data(using: .utf8)
        
        let chimcharJSON = """
        {
            "id": 390,
            "name": "chimchar",
            "types": [{"type": {"name": "fire"}}],
            "sprites": {
                "front_default": "https://...",
                "other": {"official-artwork": {"front_default": "https://..."}}
            },
            "stats": [
                {"base_stat": 55, "effort": 0, "stat": {"name": "hp"}},
                {"base_stat": 68, "effort": 1, "stat": {"name": "attack"}},
                {"base_stat": 64, "effort": 0, "stat": {"name": "defense"}},
                {"base_stat": 45, "effort": 0, "stat": {"name": "special-attack"}},
                {"base_stat": 55, "effort": 0, "stat": {"name": "special-defense"}},
                {"base_stat": 31, "effort": 0, "stat": {"name": "speed"}}
            ],
            "weight": 102,
            "height": 4
        }
        """.data(using: .utf8)

        mockURLSession.listData = json
        mockURLSession.detailDataByURL["pokemon/387"] = turtwigJSON
        mockURLSession.detailDataByURL["pokemon/390"] = chimcharJSON
        mockURLSession.response = HTTPURLResponse(
            url: URL(string: "https://pokeapi.co")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
    }
    
    func testFilterSearchText() {
        loadPokemon()
        
        let expectation = expectation(description: "fetchPokemon success")
        
        class MockDelegateWithExpectation: HomeViewModelProtocol {
            var expectation: XCTestExpectation
            var successCalled = false
            
            init(expectation: XCTestExpectation) {
                self.expectation = expectation
            }
            
            func success() {
                successCalled = true
                expectation.fulfill()
            }
            func failure() {
                expectation.fulfill()
            }
        }
        
        let delegateWithExp = MockDelegateWithExpectation(expectation: expectation)
        homeViewModel.delegate(delegate: delegateWithExp)
        
        homeViewModel.fetchPokemon()
        
        waitForExpectations(timeout: 1.0)
        
        XCTAssertTrue(delegateWithExp.successCalled)
        homeViewModel.filterSearchText("")
        XCTAssertEqual(homeViewModel.getPokemonList().count, 2)
        homeViewModel.filterSearchText("chimchar")
        XCTAssertEqual(homeViewModel.getPokemonList().count, 1)
        homeViewModel.filterSearchText("turtwig")
        XCTAssertEqual(homeViewModel.getPokemonList().count, 1)
        homeViewModel.filterSearchText("tur")
        XCTAssertEqual(homeViewModel.getPokemonList().count, 1)
        homeViewModel.filterSearchText("chim")
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
