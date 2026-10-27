//
//  PokedexProjectUITests.swift
//  PokedexProjectUITests
//
//  Created by Bruno Ryu Takahashi on 15/09/26.
//

import XCTest
@testable import PokedexProject

final class ServiceManagerTest: XCTestCase {
    
    var mockURLSession: MockURLSession!
    var serviceManager: ServiceManager!
    var homeService: HomeService!
    
    override func setUpWithError() throws {
        mockURLSession = MockURLSession()
        serviceManager = ServiceManager(session: mockURLSession)
        homeService = HomeService(serviceManager: serviceManager)
    }
    
    override func tearDownWithError() throws {
        homeService = nil
        serviceManager = nil
        mockURLSession = nil
    }
    
    func testFetchPokemonListSuccess() {
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
        
        homeService.fetchPokemonList { result in
            switch result {
            case .success(let success):
                print(success)
                XCTAssertNotNil(success, "Success não pode ser nil")
                XCTAssertGreaterThan(success.count, 0, "Deve retornar 1 ou mais pokemons")
            case .failure:
                XCTFail("Não pode cair em fail")
            }
        }
    }
    
    func testFetchPokemonFailure() {
        
        mockURLSession.error = NSError(domain: "Caso de erro", code: 404)
        
        
        homeService.fetchPokemonList { result in
            switch result {
            case .success:
                XCTFail("A request não pode cair em success")
            case .failure(let error):
                XCTAssertNotNil(error, "Conection error")
            }
        }
    }
    
    func testFetchPokemonInvalidJSONFailure() {
        
        let json = """
        {
            "results": [
                {"name": "turtwig", "url": https://pokeapi.co/api/v2/pokemon/387}
            ]
        }
        """.data(using: .utf8)
        
        mockURLSession.listData = json
        
        homeService.fetchPokemonList { result in
            switch result {
            case .success:
                XCTFail("A request não pode cair em success")
            case .failure(let error):
                XCTAssertNotNil(error, "Invalid JSON")
            }
        }
        
    }
    
    func testFetchPokemonEmptyDataSuccess() {
        
        let json = """
        {
            "results": []
        }
        """.data(using: .utf8)
        
        mockURLSession.listData = json
        
        mockURLSession.response = HTTPURLResponse(
            url: URL(string: "https://pokeapi.co")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        homeService.fetchPokemonList { result in
            switch result {
            case .success(let pokemon):
                XCTAssertEqual(pokemon.count, 0, "It should return a empty list")
            case .failure:
                XCTFail("It should'n return a error")
            }
        }
    }
    
    func testFetchPokemonInvalidURLFailure() {
        serviceManager.request(
            with: "invalid url $$##",
            method: .get,
            DecodeType: Pokemon.self
        ) { result in
            switch result {
            case .success:
                XCTFail("It should'n return a success")
            case .failure(_):
                guard case .failure(let failure) = result,
                      case .invalidURL = failure else {
                    XCTFail("Must return invalid URL")
                    return
                }
            }
        }
    }
    
    func testFetchPokemonNotFoundFailure() {
        let json = """
        {
            "results": [
                {"name": "turtwig", "url": "https://pokeapi.co/api/v2/pokemon/387"}
            ]
        }
        """.data(using: .utf8)
        
        mockURLSession.listData = json
        
        mockURLSession.response = HTTPURLResponse(
            url: URL(string: "https://pokeapi.co")!,
            statusCode: 404,
            httpVersion: nil,
            headerFields: nil
        )
        
        homeService.fetchPokemonList { result in
            switch result {
            case .success:
                XCTFail("It should'n return a success")
            case .failure(let failure):
                XCTAssertNotNil(failure, "Status code must be 404")
            }
        }
    }
    
    func testFetchPokemonInternalErrorFailure() {
        let json = """
        {
            "results": [
                {"name": "turtwig", "url": "https://pokeapi.co/api/v2/pokemon/387"}
            ]
        }
        """.data(using: .utf8)
        
        mockURLSession.listData = json
        
        mockURLSession.response = HTTPURLResponse(
            url: URL(string: "https://pokeapi.co")!,
            statusCode: 500,
            httpVersion: nil,
            headerFields: nil
        )
        
        homeService.fetchPokemonList { result in
            switch result {
            case .success:
                XCTFail("It should'n return a success")
            case .failure(let failure):
                XCTAssertNotNil(failure, "Status code must be 500")
            }
        }
    }
    
}

class MockURLSession: URLSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    var listData: Data?
    var detailData: Data?
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        if request.url?.absoluteString.contains("pokemon?limit") == true {
            print("1- ServiceManagerTest success")
            completionHandler(listData, response, error)
        } else if request.url?.absoluteString.contains("pokemon/387") == true {
            print("1 -ServiceManagerTest success")
            completionHandler(detailData, response, error)
        } else {
            print("ServiceManagerTest failure")
            completionHandler(data, response, error)
        }
    }
}
