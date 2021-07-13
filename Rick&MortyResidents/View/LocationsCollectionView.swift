//
//  LocationsCollectionView.swift
//  Rick&MortyResidents
//
//  Created by Pedro Enrique Trujillo Vargas on 7/12/21.
//


import UIKit

class LocationsCollectionView: UICollectionView {

    init(frame: CGRect) {
        let layout = LocationsCollectionViewFlowLayout(frame: frame)
        super.init(frame: frame, collectionViewLayout: layout)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.alwaysBounceVertical = true
        self.backgroundColor = .systemBackground
        self.register(LocationsCollectionViewCell.self, forCellWithReuseIdentifier: LocationsCollectionViewCell.reuserIdentifier)
    }

}
