//
//  InfoScrollView.swift
//  VisiaGoogle
//
//  Created by Nikita Stepanov on 03.12.2023.
//

import Foundation
import UIKit
import GoogleMaps

final class InfoScrollView: UIScrollView {
    
    // MARK: UI elements
    private lazy var placeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "placeImage")
        return imageView
    }()
    
    private lazy var placeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter", size: 16)
        label.textColor = .black
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter", size: 12)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var placeCategoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter", size: 14)
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var workingTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter", size: 12)
        label.textColor = .black
        return label
    }()
    
    private let starsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    // MARK: constraints
    private var placeNameLabelTopConstraint: NSLayoutConstraint?
    private var imageH: NSLayoutConstraint?
    private var imageW: NSLayoutConstraint?
    private var placenameLabelT: NSLayoutConstraint?
    private var infolabelTopAnchor: NSLayoutConstraint?
    
    // MARK: initialization
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0,
                                 y: 0,
                                 width: 0,
                                 height: 0))
        startAppearance()
        self.contentSize = CGSize(width: 0,
                                  height: 900)
    }
    
    func startAppearance() {
        imageH = placeImage.heightAnchor.constraint(equalToConstant: 0)
        imageW = placeImage.widthAnchor.constraint(equalToConstant: 0)
        placenameLabelT = placeImage.topAnchor.constraint(equalTo: self.topAnchor,
                                                         constant: 0)
        infolabelTopAnchor = infoLabel.topAnchor.constraint(equalTo: starsStackView.bottomAnchor,
                                         constant: 70)
        
        let border = Border(image: UIImage(named: "line"))
        
        [placeNameLabel,
         placeCategoryLabel,
         placeImage,
         starsStackView,
         infoLabel,
         border,
         workingTimeLabel].forEach { subView in
            self.addSubview(subView)
            subView.translatesAutoresizingMaskIntoConstraints = false
        }
        self.showsVerticalScrollIndicator = false
        
        NSLayoutConstraint.activate([placeImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                                     placenameLabelT!,
                                     imageH!,
                                     imageW!,
                                     
                                     
                                     placeNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor,
                                                                          constant: 28),
                                     placeNameLabel.topAnchor.constraint(equalTo: placeImage.bottomAnchor,
                                                                         constant: 25),
                                     
                                     placeCategoryLabel.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor,
                                                                             constant: 10),
                                     placeCategoryLabel.leftAnchor.constraint(equalTo: placeNameLabel.leftAnchor),
                                     
                                     starsStackView.topAnchor.constraint(equalTo: placeCategoryLabel.bottomAnchor,
                                                                         constant: 10),
                                     starsStackView.leadingAnchor.constraint(equalTo: placeNameLabel.leadingAnchor),
                                     starsStackView.heightAnchor.constraint(equalToConstant: 20),
                                     starsStackView.widthAnchor.constraint(equalToConstant: 116),
                                     
                                     infoLabel.widthAnchor.constraint(equalToConstant: 336),
                                     infolabelTopAnchor!,
                                     infoLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                                     
                                     workingTimeLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor,
                                                                           constant: 10),
                                     workingTimeLabel.leadingAnchor.constraint(equalTo: infoLabel.leadingAnchor),
                                     
                                     border.widthAnchor.constraint(equalToConstant: 336),
                                     border.heightAnchor.constraint(equalToConstant: 1),
                                     border.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                                     border.topAnchor.constraint(equalTo: workingTimeLabel.bottomAnchor,
                                                                 constant: 10)
                                     
                                    ])
        
        placeCategoryLabel.text = "Кафе"
        infoLabel.text = "Брехаловка — чудесное место со своими традициями на набережной Сухума. В нем просто приятно посидеть хоть в зной. Хоть в прохладу и любоваться морем"
        workingTimeLabel.text = "До 00:00"
        fillStarsView()
        self.isScrollEnabled = false
        
    }
    public func setUp(marker: GMSMarker) {
        placeNameLabel.text = marker.title
        
    }
    
    
    private func fillStarsView(){
        starsStackView.addArrangedSubviews(UIImageView(image: UIImage(named: "starFilled")),
                                           UIImageView(image: UIImage(named: "starFilled")),
                                           UIImageView(image: UIImage(named: "starFilled")),
                                           UIImageView(image: UIImage(named: "starFilled")),
                                           UIImageView(image: UIImage(named: "star")))
    }
    
    public func updateImageConstraint(_ percent: Double) {
        self.imageH?.constant = percent * 142
        self.imageW?.constant = percent * 340
        self.placenameLabelT?.constant = 25 * percent
        self.infolabelTopAnchor?.constant = 70 - 60 * percent
        self.placeImage.layer.opacity = Float(1 * percent)
        self.updateConstraintsIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
