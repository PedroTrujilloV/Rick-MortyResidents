//
//  ResidentsCollectionViewFlowLayout.swift
//  Rick&MortyResidents
//
//  Created by Pedro Enrique Trujillo Vargas on 7/14/21.
//

import UIKit

class ResidentsCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    init(frame:CGRect) {
        super.init()
        let numberOfRows = 5
        let width = frame.width
        let height = frame.height
        let numberOfColumns = 4
        let minimumInteritemSpacing = CGFloat.FlowLayout.Spacing.big
        self.sectionInset = UIEdgeInsets(top: 10, left: minimumInteritemSpacing, bottom: 10, right: minimumInteritemSpacing)
        self.minimumInteritemSpacing = minimumInteritemSpacing
        self.minimumLineSpacing = CGFloat.FlowLayout.Spacing.Xlarge * 2

        let horizontalExtraSpace = ( CGFloat( numberOfColumns ) * minimumInteritemSpacing ) + ( minimumInteritemSpacing * 2 )
        let wSideLenght = (  width  / CGFloat( numberOfColumns ) ) + horizontalExtraSpace
        let verticalExtraSpace = minimumInteritemSpacing * CGFloat(numberOfRows)  + ( minimumInteritemSpacing * 2 )
        let vSideLenght = ( height - verticalExtraSpace ) / CGFloat( numberOfRows )
        self.itemSize = CGSize(width: wSideLenght, height: vSideLenght )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
