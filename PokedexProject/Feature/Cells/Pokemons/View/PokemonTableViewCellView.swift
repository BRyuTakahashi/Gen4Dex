//
//  PokemonTableViewCellView.swift
//  PokedexProject
//
//  Created by Bruno Ryu Takahashi on 11/06/26.
//

import UIKit

class PokemonCollectionViewCellView: UIView {
    
    lazy var pokeballBGImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "pokeball-icon")
        imageView.layer.opacity = 0.2
        return imageView
    }()
    
    lazy var pokemonNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    lazy var pokemonNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    lazy var type1View: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var type2View: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var type1Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 8)
        label.textColor = .white
        return label
    }()
    
    lazy var type2Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 8)
        label.textColor = .white
        return label
    }()
    
    lazy var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        addSubview(pokeballBGImageView)
        addSubview(pokemonNameLabel)
        addSubview(pokemonNumberLabel)
        type1View.addSubview(type1Label)
        type2View.addSubview(type2Label)
        addSubview(type1View)
        addSubview(type2View)
        addSubview(pokemonImageView)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            pokeballBGImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 25),
            pokeballBGImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 25),
            pokeballBGImageView.heightAnchor.constraint(equalToConstant: 110),
            pokeballBGImageView.widthAnchor.constraint(equalToConstant: 110),
            
            pokemonNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            pokemonNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            pokemonNumberLabel.bottomAnchor.constraint(equalTo: pokemonNameLabel.bottomAnchor),
            pokemonNumberLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            type1View.topAnchor.constraint(equalTo: pokemonNameLabel.bottomAnchor, constant: 10),
            type1View.leadingAnchor.constraint(equalTo: pokemonNameLabel.leadingAnchor),
            type1View.heightAnchor.constraint(equalToConstant: 20),
            type1View.widthAnchor.constraint(equalToConstant: 55),
            
            type2View.topAnchor.constraint(equalTo: type1View.bottomAnchor, constant: 10),
            type2View.leadingAnchor.constraint(equalTo: pokemonNameLabel.leadingAnchor),
            type2View.heightAnchor.constraint(equalToConstant: 20),
            type2View.widthAnchor.constraint(equalToConstant: 55),
            
            type1Label.centerXAnchor.constraint(equalTo: type1View.centerXAnchor),
            type1Label.centerYAnchor.constraint(equalTo: type1View.centerYAnchor),
            
            type2Label.centerXAnchor.constraint(equalTo: type2View.centerXAnchor),
            type2Label.centerYAnchor.constraint(equalTo: type2View.centerYAnchor),
            
            pokemonImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            pokemonImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 75),
            pokemonImageView.widthAnchor.constraint(equalToConstant: 75),
        ])
    }
    
}
