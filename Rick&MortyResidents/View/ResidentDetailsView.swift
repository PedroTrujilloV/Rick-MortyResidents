//
//  ResidentDetailsView.swift
//  Rick&MortyResidents
//
//  Created by Pedro Enrique Trujillo Vargas on 7/14/21.
//

import UIKit
import Combine


class ResidentDetailsView: UIView {
    
    private var cancellable: AnyCancellable?
    private var url:String = ""

    private var thumbnailImageView:UIImageView = {
        let imageV = UIImageView()
        imageV.contentMode = .scaleAspectFill
        imageV.layer.cornerRadius = 5
        imageV.layer.masksToBounds = true
        imageV.image = UIImage(named: "logo")
        imageV.translatesAutoresizingMaskIntoConstraints = false
        return imageV
    }()
    
    private var nameLabel: UILabel =  {
        let label = UILabel()
        label.text  = "No Name"
        label.textAlignment = .center
        label.font = UIFont(name: "GetSchwifty-Regular", size: 22)
        label.textColor = UIColor.nameTextColor
        label.layer.shadowColor = UIColor.glowColor.cgColor
        label.layer.shadowOffset = CGSize.zero
        label.layer.shadowRadius = 3.0
        label.layer.shadowOpacity = 1.0
        label.layer.masksToBounds = false
        label.numberOfLines = 2
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text  = "No description"
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-Regular", size: 16)
        label.textColor = UIColor.descriptionTextColor
        label.numberOfLines = 2
        return label
    }()
    
    private var descriptionLabel2: UILabel = {
        let label = UILabel()
        label.text  = "No description"
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-Regular", size: 16)
        label.textColor = UIColor.descriptionTextColor
        label.numberOfLines = 2
        return label
    }()
    
    private var descriptionLabel3: UILabel = {
        let label = UILabel()
        label.text  = "No description"
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-Regular", size: 16)
        label.textColor = UIColor.descriptionTextColor
        label.numberOfLines = 2
        return label
    }()
    
    private var otherInfo:UITextView = {
       let label = UITextView()
        label.text  = "No Other Info."
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Light", size: 14)
        return label
    }()
    
    private var textStackView :UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = .fill
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var stackView :UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = .fill
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    private let defaultImage = UIImage(named: "logo")

    init(frame: CGRect, viewModel:  ResidentViewModel) {
        super.init(frame: frame)
        setup()
        set(from: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit  {
        cancellable?.cancel()
    }
    
    private func setup(){
        setupStackView()
        setupTextStackView()
        setupImageViewConstraints()
        setupTextConstraints()
        setupStyle()
    }
    
    private func setupStyle() {
        self.backgroundColor = UIColor.systemBackground
    }
       
    private func setupStackView(){

        self.addSubview(stackView)
        stackView.addArrangedSubview(thumbnailImageView)
        stackView.addArrangedSubview(textStackView)
        
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 55.0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30.0).isActive = true
        stackView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    }
    
    private func setupTextStackView() {
        textStackView.addArrangedSubview(nameLabel)
        textStackView.addArrangedSubview(descriptionLabel)
        textStackView.addArrangedSubview(descriptionLabel2)
        textStackView.addArrangedSubview(descriptionLabel3)

        textStackView.addArrangedSubview(otherInfo)
        textStackView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
    }
    
    private func setupImageViewConstraints(){
        thumbnailImageView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.5).isActive = true
        thumbnailImageView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
    }
       
    private func setupTextConstraints(){
        nameLabel.widthAnchor.constraint(equalTo: textStackView.widthAnchor, multiplier: 0.9).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: textStackView.heightAnchor, multiplier: 0.2).isActive = true
        descriptionLabel.widthAnchor.constraint(equalTo: textStackView.widthAnchor, multiplier: 0.9).isActive = true
        descriptionLabel2.widthAnchor.constraint(equalTo: textStackView.widthAnchor, multiplier: 0.9).isActive = true
        descriptionLabel3.widthAnchor.constraint(equalTo: textStackView.widthAnchor, multiplier: 0.9).isActive = true
        otherInfo.widthAnchor.constraint(equalTo: textStackView.widthAnchor, multiplier: 0.9).isActive = true
    }

    
    public func set(from viewModel:ResidentViewModel) {
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.fullStatus
        descriptionLabel2.text = viewModel.lastKnownLocation
        descriptionLabel3.text = viewModel.firstSeenIn
        bind(viewModel)
    }
    
    private func bind(_ viewModel: ResidentViewModel) {
        if let imgUrl = viewModel.imageURL {
            cancellable = ImageLoader.shared.loadImage(from: imgUrl)
                .handleEvents( receiveCompletion: { (completion) in
                    // do something here
                })
                .assign(to: \.thumbnailImageView.image, on: self )
        }
    }
    
}

