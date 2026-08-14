//
//  PokemonTableViewCell.swift
//  PokedexProject
//
//  Created by Bruno Ryu Takahashi on 11/06/26.
//

import UIKit
import SDWebImage

class PokemonCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: PokemonCollectionViewCell.self)
    
    lazy var pokemonCollectionCell: PokemonCollectionViewCellView = {
        let view = PokemonCollectionViewCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupCell(pokemons: [Pokemon], indexPath: IndexPath) {
        let pokemon = pokemons[indexPath.row]
        pokemonCollectionCell.pokemonNameLabel.text = pokemon.name.capitalized
        pokemonCollectionCell.pokemonNumberLabel.text = String(format: "#%03d", pokemon.id - 386)
        
        if pokemon.types.count > 1 {
            pokemonCollectionCell.type2Label.text = pokemon.types[1].type.name.capitalized
            pokemonCollectionCell.type2Label.isHidden = false
            pokemonCollectionCell.type2View.isHidden = false
        } else {
            pokemonCollectionCell.type2Label.isHidden = true
            pokemonCollectionCell.type2View.isHidden = true
        }
        
        pokemonCollectionCell.type1Label.text = pokemon.types[0].type.name.capitalized
        
        let typeColor = TypeColor(rawValue: pokemon.types[0].type.name)
        pokemonCollectionCell.backgroundColor = typeColor?.backgroundColor
        pokemonCollectionCell.type1View.backgroundColor = typeColor?.typeViewColor
        pokemonCollectionCell.type2View.backgroundColor = typeColor?.typeViewColor
        
        pokemonCollectionCell.pokemonImageView.sd_setImage(with: URL(string: pokemon.sprites.other?.officialArtwork?.frontDefault ?? ""))
        
    }
    
    private func addViews() {
        contentView.addSubview(pokemonCollectionCell)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            pokemonCollectionCell.topAnchor.constraint(equalTo: topAnchor),
            pokemonCollectionCell.leadingAnchor.constraint(equalTo: leadingAnchor),
            pokemonCollectionCell.trailingAnchor.constraint(equalTo: trailingAnchor),
            pokemonCollectionCell.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
}
