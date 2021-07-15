//
//  ResidentsCollectionView.swift
//  Rick&MortyResidents
//
//  Created by Pedro Enrique Trujillo Vargas on 7/14/21.
//

import Foundation
import UIKit

class ResidentsCollectionView: UICollectionView {

    init(frame: CGRect) {
        let layout = ResidentsCollectionViewFlowLayout(frame: frame)
        super.init(frame: frame, collectionViewLayout: layout)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.alwaysBounceVertical = true
        self.backgroundColor = .systemBackground
        self.register(ResidentCollectionViewCell.self, forCellWithReuseIdentifier: ResidentCollectionViewCell.reuserIdentifier)
    }

}

