//
//  HomeModel.swift
//  PokedexProject
//
//  Created by Bruno Ryu Takahashi on 08/07/26.
//

import UIKit

class HomeViewModel: NSObject {

    private var pokemonList: [Pokemon] = []
    public var searchPokemonList: [Pokemon] = []
    
    private let homeService: HomeService = HomeService()
    
    private weak var delegate: HomeViewModelProtocol?
    
    public func delegate(delegate: HomeViewModelProtocol?) {
        self.delegate = delegate
    }
    
    public func fetchPokemon() {
        homeService.fetchPokemonList { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                self.pokemonList = success.sorted { $0.id < $1.id }
                self.delegate?.success()
            case .failure(let failure):
                print(failure)
                self.delegate?.failure()
            }
        }
    }
    
    public func numberOfItems() -> Int {
        return searchPokemonList.count
    }

    public func getPokemonList() -> [Pokemon] {
        return searchPokemonList
    }
    
    public func getPokemon(indexPath: IndexPath) -> Pokemon {
        return searchPokemonList[indexPath.row]
    }
    
    var typeFilter: String?
    
    public func filterSearchText(_ text: String) {
        var filteredList: [Pokemon] = []
        
        if let typeFilter = typeFilter {
            filteredList = pokemonList.filter {
                $0.types.contains(where: {$0.type.name == typeFilter})
            }
        } else {
            filteredList = pokemonList
        }
        
        if text.isEmpty {
            searchPokemonList = filteredList
        } else {
            searchPokemonList = filteredList.filter {
                $0.name.lowercased().contains(text.lowercased())
            }
        }
    }
}


protocol HomeViewModelProtocol: AnyObject {
    func success()
    func failure()
}
