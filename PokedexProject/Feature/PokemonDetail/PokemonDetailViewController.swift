//
//  PokemonDetailViewController.swift
//  PokedexProject
//
//  Created by Bruno Ryu Takahashi on 15/07/26.
//

import UIKit
import SDWebImage

struct PokemonStat {
    let name: String
    let value: String
}

class PokemonDetailViewController: UIViewController {
    
    var pokemonDetailView: PokemonDetailView?
    let pokemonDetailViewModel: PokemonDetailViewModel = PokemonDetailViewModel()
    var pokemon: Pokemon
    var measures: [PokemonStat] = []
    var stats: [PokemonStat] = []
    
    func buildStats() {
        measures = [
            PokemonStat(name: "Height", value: String(format: "%.1fM", Double(pokemon.height) / 10)),
            PokemonStat(name: "Weight", value: String(format: "%.1fKg", Double(pokemon.weight) / 10)),
        ]
        
        stats = [
            PokemonStat(name: "HP", value: "\(pokemon.stats[0].baseStat)"),
            PokemonStat(name: "Attack", value: "\(pokemon.stats[1].baseStat)"),
            PokemonStat(name: "Defense", value: "\(pokemon.stats[2].baseStat)"),
            PokemonStat(name: "Sp. Attack", value: "\(pokemon.stats[3].baseStat)"),
            PokemonStat(name: "Sp. Defense", value: "\(pokemon.stats[4].baseStat)"),
            PokemonStat(name: "Speed", value: "\(pokemon.stats[5].baseStat)"),
        ]
    }
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        super.init(nibName: nil, bundle: nil)
        buildStats()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonDetailView?.configCollectionView(delegate: self, dataSource: self)
    }
    
    override func loadView() {
        pokemonDetailView = PokemonDetailView()
        view = pokemonDetailView
        setupElements()
    }
    
    private func setupElements() {
        pokemonDetailView?.pokemonNameLabel.text = pokemon.name.capitalized
        pokemonDetailView?.pokemonNumberLabel.text = String(format: "#%03d", pokemon.id - 386)
        
        if pokemon.types.count > 1 {
            pokemonDetailView?.type2Label.text = pokemon.types[1].type.name.capitalized
            pokemonDetailView?.type2Label.isHidden = false
            pokemonDetailView?.type2View.isHidden = false
        } else {
            pokemonDetailView?.type2Label.isHidden = true
            pokemonDetailView?.type2View.isHidden = true
        }
        
        pokemonDetailView?.type1Label.text = pokemon.types[0].type.name.capitalized
        
        let typeColor = TypeColor(rawValue: pokemon.types[0].type.name)
        pokemonDetailView?.backgroundColor = typeColor?.backgroundColor
        pokemonDetailView?.type1View.backgroundColor = typeColor?.typeViewColor
        pokemonDetailView?.type2View.backgroundColor = typeColor?.typeViewColor
        
        pokemonDetailView?.pokemonImageView.sd_setImage(with: URL(string: pokemon.sprites.other?.officialArtwork?.frontDefault ?? ""))
        pokemonDetailView?.backgroundView.backgroundColor = TypeColor(rawValue: pokemon.types[0].type.name)?.backgroundColor
    }
}

extension PokemonDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? measures.count : stats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonDetailCollectionViewCell.identifier, for: indexPath) as? PokemonDetailCollectionViewCell
        let stat =  indexPath.section == 0 ? measures[indexPath.row] : stats[indexPath.row]
        cell?.setupView(pokemonStat: stat)
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeaderView", for: indexPath)  as! SectionHeaderView
        header.titleLabel.text = indexPath.section == 0 ? "Measure" : "Stat"
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 35)
    }
}
