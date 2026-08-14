//
//  PokemonDetailCollectionViewCell.swift
//  PokedexProject
//
//  Created by Bruno Ryu Takahashi on 20/07/26.
//

import UIKit

class PokemonDetailCollectionViewCell: UICollectionViewCell {
 
    static let identifier: String = String(describing: PokemonDetailCollectionViewCell.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var pokemonDetailViewCellView: PokemonDetailCollectionViewCellView = {
        let view = PokemonDetailCollectionViewCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func addViews() {
        contentView.addSubview(pokemonDetailViewCellView)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            pokemonDetailViewCellView.topAnchor.constraint(equalTo: topAnchor),
            pokemonDetailViewCellView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pokemonDetailViewCellView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pokemonDetailViewCellView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    public func setupView(pokemonStat: PokemonStat) {
        pokemonDetailViewCellView.dataTypeLabel.text = pokemonStat.name
        pokemonDetailViewCellView.dataLabel.text = pokemonStat.value
    }
}
