//
//  LocationsCollectionViewModel.swift
//  Rick&MortyResidents
//
//  Created by Pedro Enrique Trujillo Vargas on 7/12/21.
//

import Foundation


class LocationsCollectionViewModel: NSObject {
    
    public var title = "Locations List"
    private var dataSource: DataSource?
    public var dataSourceList:Array<LocationViewModel> = []
    public weak var delegate: LocationsCollectionViewControllerDelegate?
    
    override init() {
        super.init()
        dataSource = DataSource(delegate: self)
    }
    
    public func paginate(){
        guard let dataSource = dataSource else {
            print("\n ⚠️ LocationsCollectionViewModel.paginate(), dataSource = nil, not possible load next batch")
            return
        }
        if dataSource.totalItems > dataSourceList.count {
            dataSource.loadNext()
        }
    }
    
}

extension LocationsCollectionViewModel: DataSourceDelegate {
    func dataSourceDidLoad(dataSource: Array<LocationViewModel>) {
        self.dataSourceList = dataSource
        self.delegate?.updateCollectionView(with: dataSource)
    }
}
