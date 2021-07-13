//
//  LocationsCollectionViewFlowLayout.swift
//  Rick&MortyResidents
//
//  Created by Pedro Enrique Trujillo Vargas on 7/13/21.
//

import Foundation
import UIKit

class LocationsCollectionViewFlowLayout: UICollectionViewFlowLayout {

    init(frame:CGRect) {
        super.init()
        let numberOfRows = 9
        let width = frame.width
        let numberOfColumns = Int.FlowLayout.columns.single
        self.sectionInset = UIEdgeInsets(top: 10, left: CGFloat.FlowLayout.Spacing.normal, bottom: 10, right: CGFloat.FlowLayout.Spacing.normal)
        self.minimumInteritemSpacing = CGFloat.FlowLayout.Spacing.normal
        self.minimumLineSpacing = CGFloat.FlowLayout.Spacing.Xlarge
        
        let extraSpace = ( CGFloat( numberOfColumns ) * CGFloat.FlowLayout.Spacing.normal ) + CGFloat.FlowLayout.Spacing.normal
        let sideLenght = ( ( width  ) / CGFloat.FlowLayout.Spacing.normal )
        let height = ( frame.height - extraSpace ) / CGFloat(numberOfRows )
        self.itemSize = CGSize(width: sideLenght, height: height )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

