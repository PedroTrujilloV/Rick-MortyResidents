//
//  LocationsCollectionViewController.swift
//  Rick&MortyResidents
//
//  Created by Pedro Enrique Trujillo Vargas on 7/12/21.
//

import UIKit

protocol LocationsCollectionViewControllerDelegate: NSObject {
    func updateCollectionView(with list: Array<LocationViewModel>)
}

class LocationsCollectionViewController: UICollectionViewController  {
    
    
    private var viewModel = LocationsCollectionViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        viewModel.delegate = self
        navigationItem.title = viewModel.title
        collectionView = LocationsCollectionView(frame: collectionView.frame)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
     }

}

extension LocationsCollectionViewController: LocationsCollectionViewControllerDelegate {
    func updateCollectionView(with list: Array<LocationViewModel>) {
        self.collectionView?.reloadData()
    }
}

extension LocationsCollectionViewController { // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataSourceList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == viewModel.dataSourceList.count - 1 { // last cell
            viewModel.paginate()
        }
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationsCollectionViewCell.reuserIdentifier, for: indexPath) as?
            LocationsCollectionViewCell {
            let vm = viewModel.dataSourceList[indexPath.item]
            cell.set(from: vm)
            return cell
        } else {
            print("Problem at dequeueReusableCell for LocationsCollectionViewCell")
        }
        return collectionView.dequeueReusableCell(withReuseIdentifier: LocationsCollectionViewCell.reuserIdentifier, for: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let locationVM = viewModel.dataSourceList[indexPath.row]
        let residentsCollectionVM = ResidentsCollectionViewModel(with: locationVM)
        let residentsCollectionVC = ResidentsCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        residentsCollectionVC.viewModel = residentsCollectionVM
        presentDetailViewController(residentsCollectionVC)
    }
    
    private func presentDetailViewController(_ detailVC: ResidentsCollectionViewController) {
        detailVC.modalPresentationStyle = .fullScreen
        self.show(detailVC, sender: nil)
    }
}


