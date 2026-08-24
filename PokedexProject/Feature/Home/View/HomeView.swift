//
//  HomeView.swift
//  PokedexProject
//
//  Created by Bruno Ryu Takahashi on 11/06/26.
//

import UIKit

class HomeView: UIView {
    
    lazy var pokeballImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "pokeball-icon")
        imageView.layer.opacity = 0.3
        return imageView
    }()
    
    lazy var filterTextField: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.backgroundColor = .clear
        searchBar.backgroundImage = UIImage()
        searchBar.isTranslucent = true
        searchBar.placeholder = "Ex: Pikachu"
        return searchBar
    }()
    
    public func configFilterTextField(delegate: UISearchBarDelegate) {
        self.filterTextField.delegate = delegate
    }
    
    lazy var pokemonsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        //        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: PokemonCollectionViewCell.identifier)
        return collectionView
    }()
    
    public func configCollectionViewProtocol(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        pokemonsCollectionView.delegate = delegate
        pokemonsCollectionView.dataSource = dataSource
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "background-white")
        addViews()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        addSubview(pokeballImageView)
        addSubview(filterTextField)
        addSubview(pokemonsCollectionView)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            pokeballImageView.topAnchor.constraint(equalTo: topAnchor, constant: -60),
            pokeballImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 90),
            pokeballImageView.heightAnchor.constraint(equalToConstant: 300),
            pokeballImageView.widthAnchor.constraint(equalToConstant: 300),
            
            filterTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            filterTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            filterTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            filterTextField.heightAnchor.constraint(equalToConstant: 38),
            
            pokemonsCollectionView.topAnchor.constraint(equalTo: filterTextField.bottomAnchor, constant: 30),
            pokemonsCollectionView.leadingAnchor.constraint(equalTo: filterTextField.leadingAnchor),
            pokemonsCollectionView.trailingAnchor.constraint(equalTo: filterTextField.trailingAnchor),
            pokemonsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
}
