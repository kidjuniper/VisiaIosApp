//
//  PointsBottomSheet.swift
//  VisiaGoogle
//
//  Created by Nikita Stepanov on 03.12.2023.
//

import Foundation
import UIKit
import GoogleMaps

final class PointsScrollView: UIScrollView {
    // MARK: global
    private var selectedMarker: GMSMarker?
//    private var animationDelegate: ?
    
    // MARK: constraints
    public var tableHeightAnchor: NSLayoutConstraint?
    
    // MARK: UI elements
    public lazy var directionsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DirectionsTableViewCell.self,
                           forCellReuseIdentifier: "DirectionsTableViewCell")
        tableView.separatorColor = .clear
        tableView.clipsToBounds = true
        tableView.isScrollEnabled = false
        tableView.allowsSelection = true
        return tableView
    }()
    
    public lazy var routeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter", size: 16)
        label.textColor = .black
        label.text = "Построение маршрута"
        return label
    }()
    
    public lazy var bottomSheetViewAddButton: UIButton = {
        let bottomSheetViewAddButton = UIButton()
        bottomSheetViewAddButton.addTarget(self,
                                           action: #selector(addStop),
                                           for: .touchUpInside)
        bottomSheetViewAddButton.setTitle("Добавить в маршрут",
                                          for: .normal)
        bottomSheetViewAddButton.layer.cornerRadius = 7
        bottomSheetViewAddButton.backgroundColor = UIColor(named: "blueButtons")
        return bottomSheetViewAddButton
    }()
    
    public lazy var beginingPointButton: UIButton = {
        let button = UIButton()
        button.addTarget(self,
                         action: #selector(drawRoute),
                         for: .touchUpInside)
        button.layer.cornerRadius = 12
        button.contentHorizontalAlignment = .left
        button.setAttributedTitle(NSAttributedString(string: "  Откуда?",
                                                     attributes: [NSAttributedString.Key.font : UIFont(name: "Futura",
                                                                                                       size: 14)!,
                                                                  NSAttributedString.Key.foregroundColor : UIColor.lightGray.cgColor])
                                  ,
                                  for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.backgroundColor = UIColor(named: "cellBackground")
        button.layer.borderWidth = 1
        return button
    }()
    
    public lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "cancelRoute"),
                        for: .normal)
        button.addTarget(self,
                         action: #selector(removeRoutes),
                         for: .touchUpInside)
        return button
    }()
    
    public lazy var beginingPointImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "beginingPoint"))
        return imageView
    }()
    
    public lazy var interactionImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "di"))
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0,
                                 y: 0,
                                 width: 0,
                                 height: 0))
        setUp()
        self.contentSize = CGSize(width: 0,
                                  height: 900)
        self.isScrollEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        [directionsTableView,
         routeLabel,
         cancelButton,
         beginingPointButton,
         beginingPointImageView,
         interactionImageView].forEach { views in
            self.addSubview(views)
            views.translatesAutoresizingMaskIntoConstraints = false
        }
        
        tableHeightAnchor = directionsTableView.heightAnchor.constraint(equalToConstant: CGFloat(min(RouteHolder.shared.stops.count, 
                                                                                                     7) * 55))
        
        directionsTableView.delegate = self
        directionsTableView.dataSource = self
        
        NSLayoutConstraint.activate([
            interactionImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            interactionImageView.topAnchor.constraint(equalTo: self.topAnchor,
                                                       constant: 10),
            interactionImageView.widthAnchor.constraint(equalToConstant: 52),
            interactionImageView.heightAnchor.constraint(equalToConstant: 6),
            
            beginingPointButton.topAnchor.constraint(equalTo: routeLabel.bottomAnchor,
                                                     constant: 20),
            beginingPointButton.widthAnchor.constraint(equalToConstant: 300),
            beginingPointButton.heightAnchor.constraint(equalToConstant: 45),
            beginingPointButton.trailingAnchor.constraint(equalTo: directionsTableView.trailingAnchor),
            
            beginingPointImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                            constant: 25),
            beginingPointImageView.centerYAnchor.constraint(equalTo: beginingPointButton.centerYAnchor),
            beginingPointImageView.widthAnchor.constraint(equalToConstant: 30),
            beginingPointImageView.heightAnchor.constraint(equalToConstant: 30),
            
            directionsTableView.topAnchor.constraint(equalTo: beginingPointButton.bottomAnchor,
                                                     constant: 5),
            directionsTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                         constant: 25),
            directionsTableView.widthAnchor.constraint(equalToConstant: 340),
            
            tableHeightAnchor!,
            
            cancelButton.centerYAnchor.constraint(equalTo: routeLabel.centerYAnchor),
            cancelButton.leftAnchor.constraint(equalTo: self.leftAnchor,
                                               constant: 25),
            cancelButton.heightAnchor.constraint(equalToConstant: 29),
            cancelButton.widthAnchor.constraint(equalToConstant: 29),
            
            routeLabel.leftAnchor.constraint(equalTo: cancelButton.rightAnchor,
                                             constant: 5),
            routeLabel.topAnchor.constraint(equalTo: self.topAnchor,
                                            constant: 45)
        ])
    }
    
    func selectMarker(_ marker: GMSMarker) {
        selectedMarker = marker
    }
    
    func updateData() {
        directionsTableView.reloadData()
    }
    func updateTableHeight(constant: Double) {
        tableHeightAnchor?.constant = constant
    }
    
    @objc
    func addStop() {
        RouteHolder.shared.addNewStop(selectedMarker!)
        
    }
    
    @objc
    func drawRoute() {
        RouteHolder.shared.drawRoute()
    }
    
    @objc
    func removeRoutes() {
        RouteHolder.shared.removeRoutes()
//        animationDelegate.removeRoutesAnimation()
    }
}

extension PointsScrollView: UITableViewDelegate {
    
}

extension PointsScrollView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, 
                   numberOfRowsInSection section: Int) -> Int {
        RouteHolder.shared.stops.count
    }
    
    func tableView(_ tableView: UITableView, 
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.directionsTableView.dequeueReusableCell(withIdentifier: "DirectionsTableViewCell",
                                                                for: indexPath) as! DirectionsTableViewCell
        cell.placeLabel.text = RouteHolder.shared.stops[indexPath.row].title
        return cell
    }
}
