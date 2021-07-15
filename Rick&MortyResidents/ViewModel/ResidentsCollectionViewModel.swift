//
//  ResidentsCollectionViewModel.swift
//  Rick&MortyResidents
//
//  Created by Pedro Enrique Trujillo Vargas on 7/14/21.
//

import Foundation

class ResidentsCollectionViewModel: NSObject { //TODO: Add Rrsidents Collection view delgetae to this
    
    public var title = "Residents List"
    private var locationViewModel:LocationViewModel
    public var dataSourceList:Array<ResidentViewModel> = []
    public weak var delegate: ResidentsCollectionViewControllerDelegate?
    
    init(with viewModel:LocationViewModel) {
        locationViewModel = viewModel
    }
    
    public func loadResidentsDataList() {
        let group = DispatchGroup()
        for urlString in locationViewModel.residents {
            group.enter()
            DataSource.retrieveResident(with: urlString) {[weak self] resident in
                if let resident = resident {
                    let residentViewModel = ResidentViewModel(model: resident)
                    self?.dataSourceList.append(residentViewModel)
                    group.leave()
                }
            }
        }
        group.notify(qos: DispatchQoS.default, flags: DispatchWorkItemFlags.assignCurrentContext, queue: DispatchQueue.main) {
            print("\n\n\n>>>> qos dataSourceList: \(self.dataSourceList) <<< \n\n\n")
            self.delegate?.updateCollectionView(with: self.dataSourceList)
        }
        
    }
    
}

