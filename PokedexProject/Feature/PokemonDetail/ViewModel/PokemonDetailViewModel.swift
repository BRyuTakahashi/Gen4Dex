//
//  PokemonDetailViewModel.swift
//  PokedexProject
//
//  Created by Bruno Ryu Takahashi on 22/07/26.
//

import UIKit

class PokemonDetailViewModel: NSObject {

    public func numberOfItems(pokemonStats: [PokemonStat]) -> Int {
        return pokemonStats.count
    }
}
