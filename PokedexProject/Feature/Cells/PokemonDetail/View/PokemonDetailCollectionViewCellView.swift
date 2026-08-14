//
//  PokemonDetailCollectionViewControllerView.swift
//  PokedexProject
//
//  Created by Bruno Ryu Takahashi on 20/07/26.
//

import UIKit

class PokemonDetailCollectionViewCellView: UIView {

    lazy var dataTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    lazy var dataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        return label
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
        addSubview(dataTypeLabel)
        addSubview(dataLabel)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            dataTypeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 1),
            dataTypeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            
            dataLabel.bottomAnchor.constraint(equalTo: dataTypeLabel.bottomAnchor),
            dataLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
        ])
    }
}
