//
//  DirectionsTableViewCell.swift
//  VisiaGoogle
//
//  Created by Nikita Stepanov on 28.11.2023.
//

import UIKit

class DirectionsTableViewCell: UITableViewCell {
    
    public let placeLabel = UILabel()
    public let bgLabel = UILabel()
    private var pointImage = UIImageView(image: UIImage(named: "circleRouteTableView"))
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default,
                   reuseIdentifier: "DirectionsTableViewCell")
        cellSettings()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected,
                          animated: animated)
    }
    func cellSettings() {
        selectionStyle = .none
        [bgLabel,
         placeLabel,
         pointImage].forEach { item in
            item.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(item)
        }
        bgLabel.backgroundColor = UIColor(named: "cellBackground")
        bgLabel.layer.cornerRadius = 12
        bgLabel.clipsToBounds = true
        
        placeLabel.textColor = .black
        placeLabel.font = UIFont(name: "Inter", size: 14)
        NSLayoutConstraint.activate([bgLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                                     bgLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                                     bgLabel.widthAnchor.constraint(equalToConstant: 300),
                                     bgLabel.heightAnchor.constraint(equalToConstant: 45),
                                     
                                     placeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                                     placeLabel.leadingAnchor.constraint(equalTo: bgLabel.leadingAnchor,
                                                                         constant: 15),
                                     
                                     contentView.heightAnchor.constraint(equalToConstant: 55),
                                     
                                     pointImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                                         constant: 8),
                                     pointImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                                     pointImage.heightAnchor.constraint(equalToConstant: 15),
                                     pointImage.widthAnchor.constraint(equalToConstant: 15)
                                    ])
    }
}
