//
//  ResidentsCollectionViewController.swift
//  Rick&MortyResidents
//
//  Created by Pedro Enrique Trujillo Vargas on 7/14/21.
//


import UIKit

protocol ResidentsCollectionViewControllerDelegate: NSObject {
    func updateCollectionView(with list: Array<ResidentViewModel>)
}

class ResidentsCollectionViewController: UICollectionViewController  {
    
    
    public var viewModel: ResidentsCollectionViewModel?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        viewModel?.delegate = self
        viewModel?.loadResidentsDataList()
        navigationItem.title = viewModel?.title
        collectionView = ResidentsCollectionView(frame: collectionView.frame)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
     }

}

extension ResidentsCollectionViewController: ResidentsCollectionViewControllerDelegate {
    func updateCollectionView(with list: Array<ResidentViewModel>) {
        self.collectionView?.reloadData()
    }
}

extension ResidentsCollectionViewController { // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.dataSourceList.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResidentCollectionViewCell.reuserIdentifier, for: indexPath) as?
            ResidentCollectionViewCell {
            guard let vm = viewModel?.dataSourceList[indexPath.item] else{
                print("Problem at dequeueReusableCell for ResidentCollectionViewCell no viewModel")
                return cell
            }
            cell.set(from: vm)
            return cell
        } else {
            print("Problem at dequeueReusableCell for ResidentCollectionViewCell")
        }
        return collectionView.dequeueReusableCell(withReuseIdentifier: ResidentCollectionViewCell.reuserIdentifier, for: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let residentVM = viewModel?.dataSourceList[indexPath.row] else {
            print("Problem at didSelectItemAt for viewModel.dataSourceList no residentVM for indexPath.row \(indexPath.row)")
            return
        }
        let detailVC = ResidentDetailsViewController(residentVM)
        presentDetailViewController(detailVC)

    }
    
    private func presentDetailViewController(_ detailVC: ResidentDetailsViewController) {
       let nc = UINavigationController(rootViewController: detailVC)
       nc.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
       nc.navigationBar.shadowImage = UIImage()
       nc.navigationBar.isTranslucent = true
       nc.view.backgroundColor = UIColor.clear

       self.present(nc, animated: true) {
           //do something
       }
    }
}



