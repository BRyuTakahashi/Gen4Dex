//
//  TypeColor.swift
//  PokedexProject
//
//  Created by Bruno Ryu Takahashi on 16/07/26.
//

import Foundation
import UIKit

enum TypeColor: String {
    case grass
    case fire
    case water
    case bug
    case ice
    case dragon
    case dark
    case ghost
    case fighting
    case electric
    case steel
    case normal
    case fairy
    case flying
    case ground
    case rock
    case psychic
    case poison
}

extension TypeColor {
    var backgroundColor: UIColor? {
        switch self {
        case .grass:
            return UIColor(named: "grass-pokemon-bg")
        case .fire:
            return UIColor(named: "fire-pokemon-bg")
        case .water:
            return UIColor(named: "water-pokemon-bg")
        case .bug:
            return UIColor(named: "bug-pokemon-bg")
        case .ice:
            return UIColor(named: "ice-pokemon-bg")
        case .dragon:
            return UIColor(named: "dragon-pokemon-bg")
        case .dark:
            return UIColor(named: "dark-pokemon-bg")
        case .ghost:
            return UIColor(named: "ghost-pokemon-bg")
        case .fighting:
            return UIColor(named: "fighting-pokemon-bg")
        case .electric:
            return UIColor(named: "electric-pokemon-bg")
        case .steel:
            return UIColor(named: "steel-pokemon-bg")
        case .normal:
            return UIColor(named: "normal-pokemon-bg")
        case .fairy:
            return UIColor(named: "fairy-pokemon-bg")
        case .flying:
            return UIColor(named: "flying-pokemon-bg")
        case .ground:
            return UIColor(named: "ground-pokemon-bg")
        case .rock:
            return UIColor(named: "rock-pokemon-bg")
        case .psychic:
            return UIColor(named: "psychic-pokemon-bg")
        case .poison:
            return UIColor(named: "poison-pokemon-bg")
        }
    }
    
    var typeViewColor: UIColor? {
        switch self {
        case .grass:
            return UIColor(named: "grass-pokemon-bg2")
        case .fire:
            return UIColor(named: "fire-pokemon-bg2")
        case .water:
            return UIColor(named: "water-pokemon-bg2")
        case .bug:
            return UIColor(named: "bug-pokemon-bg2")
        case .ice:
            return UIColor(named: "ice-pokemon-bg2")
        case .dragon:
            return UIColor(named: "dragon-pokemon-bg2")
        case .dark:
            return UIColor(named: "dark-pokemon-bg2")
        case .ghost:
            return UIColor(named: "ghost-pokemon-bg2")
        case .fighting:
            return UIColor(named: "fighting-pokemon-bg2")
        case .electric:
            return UIColor(named: "electric-pokemon-bg2")
        case .steel:
            return UIColor(named: "steel-pokemon-bg2")
        case .normal:
            return UIColor(named: "normal-pokemon-bg2")
        case .fairy:
            return UIColor(named: "fairy-pokemon-bg2")
        case .flying:
            return UIColor(named: "flying-pokemon-bg2")
        case .ground:
            return UIColor(named: "ground-pokemon-bg2")
        case .rock:
            return UIColor(named: "rock-pokemon-bg2")
        case .psychic:
            return UIColor(named: "psychic-pokemon-bg2")
        case .poison:
            return UIColor(named: "poison-pokemon-bg2")
        }
    }
}
