//
//  HomeViewController.swift
//  PokedexProject
//
//  Created by Bruno Ryu Takahashi on 11/06/26.
//

import UIKit

class HomeViewController: UIViewController {
    
    var homeView: HomeView?
    let homeViewModel: HomeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyboard()
        homeViewModel.fetchPokemon()
        homeViewModel.delegate(delegate: self)
        homeView?.configFilterTextField(delegate: self)
    }
    
    
    override func loadView() {
        homeView = HomeView()
        view = homeView
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.identifier, for: indexPath) as? PokemonCollectionViewCell
        cell?.setupCell(pokemons: homeViewModel.getPokemonList(), indexPath: indexPath)
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemonDetail = PokemonDetailViewController(pokemon: homeViewModel.getPokemon(indexPath: indexPath))
        self.present(pokemonDetail, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 125)
    }
    
}

extension HomeViewController: HomeViewModelProtocol {
    func success() {
        homeView?.configCollectionViewProtocol(delegate: self, dataSource: self)
        homeViewModel.filterSearchText("")
        homeView?.pokemonsCollectionView.reloadData()
    }
    
    func failure() {
        print("Failure")
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        homeViewModel.filterSearchText(searchText)
        homeView?.pokemonsCollectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
