//
//  PokemonDetailView.swift
//  PokedexProject
//
//  Created by Bruno Ryu Takahashi on 15/07/26.
//

import UIKit

class PokemonDetailView: UIView {
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var pokemonDetailView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 40
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        return view
    }()
    
    lazy var pokemonNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var pokemonNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var type1View: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        return view
    }()
    
    lazy var type2View: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        return view
    }()
    
    lazy var type1Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    lazy var type2Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    lazy var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var pokemonDataCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.backgroundColor = .white
        collectionView.register(PokemonDetailCollectionViewCell.self, forCellWithReuseIdentifier: PokemonDetailCollectionViewCell.identifier)
        collectionView.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "SectionHeaderView"
        )
        return collectionView
    }()
    
    public func configCollectionView(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        pokemonDataCollectionView.delegate = delegate
        pokemonDataCollectionView.dataSource = dataSource
        pokemonDataCollectionView.reloadData()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        addSubview(backgroundView)
        addSubview(pokemonDetailView)
        addSubview(pokemonNameLabel)
        addSubview(pokemonNumberLabel)
        type1View.addSubview(type1Label)
        type2View.addSubview(type2Label)
        addSubview(type1View)
        addSubview(type2View)
        addSubview(pokemonImageView)
        addSubview(pokemonDataCollectionView)
    }

    private func configConstraints() {
        NSLayoutConstraint.activate([
            
            pokemonDetailView.topAnchor.constraint(equalTo: topAnchor, constant: 300),
            pokemonDetailView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pokemonDetailView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pokemonDetailView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: topAnchor, constant: 350),
            
            pokemonNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            pokemonNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            
            pokemonNumberLabel.bottomAnchor.constraint(equalTo: pokemonNameLabel.bottomAnchor),
            pokemonNumberLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            
            type1View.topAnchor.constraint(equalTo: pokemonNameLabel.bottomAnchor, constant: 30),
            type1View.leadingAnchor.constraint(equalTo: pokemonNameLabel.leadingAnchor),
            type1View.heightAnchor.constraint(equalToConstant: 30),
            type1View.widthAnchor.constraint(equalToConstant: 75),
            
            type2View.topAnchor.constraint(equalTo: type1View.topAnchor),
            type2View.leadingAnchor.constraint(equalTo: type1View.leadingAnchor, constant: 80),
            type2View.heightAnchor.constraint(equalToConstant: 30),
            type2View.widthAnchor.constraint(equalToConstant: 75),
            
            type1Label.centerXAnchor.constraint(equalTo: type1View.centerXAnchor),
            type1Label.centerYAnchor.constraint(equalTo: type1View.centerYAnchor),
            
            type2Label.centerXAnchor.constraint(equalTo: type2View.centerXAnchor),
            type2Label.centerYAnchor.constraint(equalTo: type2View.centerYAnchor),
            
            pokemonImageView.bottomAnchor.constraint(equalTo: pokemonDetailView.topAnchor, constant: 70),
            pokemonImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 200),
            pokemonImageView.widthAnchor.constraint(equalToConstant: 200),
            
            pokemonDataCollectionView.topAnchor.constraint(equalTo: pokemonImageView.bottomAnchor, constant: 5),
            pokemonDataCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pokemonDataCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pokemonDataCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
