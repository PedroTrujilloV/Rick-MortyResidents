//
//  LocationsCollectionViewCell.swift
//  Rick&MortyResidents
//
//  Created by Pedro Enrique Trujillo Vargas on 7/13/21.
//

import Foundation
import UIKit
import Combine

class LocationsCollectionViewCell: UICollectionViewCell {
    static let reuserIdentifier: String = "LocationsCollectionViewCell"
    private var cancellables: Array<AnyCancellable> = []
    private static let processingQueue = DispatchQueue(label: "processingQueue")
    private let heightProportion:CGFloat = 0.65
    private let defaultImage = UIImage(named: "logo")
    private let likeStateImageView = UIImageView(image: UIImage(systemName: "heart.fill") )
    private let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    private let stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = .fill
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing  = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let textStackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = .equalCentering
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 2.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var thumbnailImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.cellImageBackgroundColor
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = true
        return imageView
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.text  = "No name"
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 15)
        label.textColor = UIColor.nameTextColor
        label.numberOfLines = 2
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text  = "No description"
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Regular", size: 12)
        label.textColor = UIColor.descriptionTextColor
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit  {
        self.cancel()
    }
    
    private func cancel(){
        _ = cancellables.map{ $0.cancel()}
    }
    
    func setup(){
        setupStackView()
        setupImageViewConstraints()
        setupTextViewConstraints()
        setupIcons()
        self.backgroundColor = .cellBackgroundColor
    }
       
    private func setupStackView(){
        
        self.addSubview(stackView)
        stackView.addArrangedSubview(thumbnailImageView)
        stackView.addArrangedSubview(textStackView)
        activityIndicator.startAnimating()
        
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
    private func setupImageViewConstraints(){
        thumbnailImageView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.9).isActive = true
        thumbnailImageView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.4).isActive = true
    }
    
    private func setupTextViewConstraints(){
        textStackView.addArrangedSubview(nameLabel)
        textStackView.addArrangedSubview(descriptionLabel)
        nameLabel.heightAnchor.constraint(equalTo: textStackView.heightAnchor, multiplier: 0.6).isActive = true
    }
    
    private func setupIcons(){
        likeStateImageView.tintColor = UIColor.brandColor
        likeStateImageView.isHidden = true
        let yPos:CGFloat = self.frame.size.height - (self.frame.size.height * heightProportion)
        activityIndicator.center = CGPoint(x: self.frame.size.width/2, y: yPos)
        self.addSubview(activityIndicator)
    }

        
    public func set(from viewModel:  LocationViewModel) {
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.type
        activityIndicator.stopAnimating()
    }

    override func prepareForReuse() {
        thumbnailImageView.image = defaultImage
        self.likeStateImageView.isHidden = true
        self.descriptionLabel.text = ""
        self.nameLabel.text = ""
        self.cancel()
    }
}
