//
//  ViewController.swift
//  VisiaGoogle
//
//  Created by Nikita Stepanov on 16.11.2023.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON

final class MapViewController: UIViewController {
    // MARK: scroll helpers
    public var isInteractiveTransitionCanBeHandled: Bool {
        isDragging
    }

    public var isDragging = false
    public var overlayTranslation: CGFloat = 0
    public var scrollViewTranslation: CGFloat = 0
    public var lastContentOffsetBeforeDragging: CGPoint = .zero
    public var didStartDragging = false
    
    // MARK: main elements
    public var currentLocation: CLLocation?
    public var map: GMSMapView?
    public var selectedMarker: GMSMarker?
    
    // MARK: place info bottom sheet
    public var previousSizeBottomSheet: Double = 0.0
    
    public lazy var bottomSheetView: UIView = {
        let bottomSheetView = UIView(frame: CGRect(x: 0,
                                                   y: 0,
                                                   width: 0,
                                                   height: 0))
        bottomSheetView.layer.cornerRadius = 25
        bottomSheetView.backgroundColor = .white
        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
        return bottomSheetView
    }()
    
    public lazy var interactionImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "di"))
        return imageView
    }()
    
    public var scroll: InfoScrollView = InfoScrollView()
    
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
    
    // MARK: selected points bottom sheet
    
    public lazy var pointsBottomSheetView: UIView = {
        let bottomSheetView = UIView(frame: CGRect(x: 0,
                                                   y: 0,
                                                   width: 0,
                                                   height: 0))
        bottomSheetView.layer.cornerRadius = 25
        bottomSheetView.backgroundColor = .white
        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
        return bottomSheetView
    }()
    
    public lazy var createRouteButton: UIButton = {
        let bottomSheetViewAddButton = UIButton()
        bottomSheetViewAddButton.addTarget(self,
                                           action: #selector(drawRoute),
                                           for: .touchUpInside)
        bottomSheetViewAddButton.setTitle("Построить маршрут",
                                          for: .normal)
        bottomSheetViewAddButton.layer.cornerRadius = 7
        bottomSheetViewAddButton.backgroundColor = UIColor(named: "blueButtons")
        return bottomSheetViewAddButton
    }()
    
    public var pointsScrollView: PointsScrollView = PointsScrollView()
    
    public var previousSizePointsBottomSheet: Double = 0.0
    
    public var directionsTableView = UITableView()
    
    // MARK: place bottom sheet view constraints
    public var centerYConstraint: NSLayoutConstraint?
    public var heightConstraint: NSLayoutConstraint?
    
    // MARK: points bottom sheet view constraints
    public var centerYConstraintPoints: NSLayoutConstraint?
    public var heightConstraintPoints: NSLayoutConstraint?
    
    // MARK: table view contraints
    public var tableHeightAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scroll.delegate = self
        pointsScrollView.delegate = self
        MapDataProvider.shared.setUpMap(view: view) { mapView in
            addMap(mapView)
        }
        setConstraints()
        view.layoutIfNeeded()
    }
}

// MARK: CLLocationManager delegate
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard locations.first != nil else {
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        //let accuracy = manager.accuracyAuthorization
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        print(error)
    }
    
}

// MARK: MapDataProvider delegate
extension MapViewController: MapDataProviderDelegate {
    func setSelfAsDelegate(_ manager: CLLocationManager) {
        manager.delegate = self
    }
}

// MARK: GMSMapView delegate
extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, 
                 didTap marker: GMSMarker) -> Bool {
        selectedMarker = marker
            // вынести в отдельную функцию в скрол 
        scroll.setUp(marker: marker)
        scroll.updateImageConstraint(0.01)
        scroll.isScrollEnabled = false
        UIView.animate(withDuration: 0.35) {
            self.centerYConstraint!.constant = 0
            self.heightConstraint!.constant = 250
            
            self.centerYConstraintPoints!.constant = self.pointsBottomSheetView.bounds.height - 40
            if RouteHolder.shared.stops.count <= 7 { // потом поменять на 8 и вынести в отдельный блок
                self.directionsTableView.isScrollEnabled = false
            }
            else {
                self.directionsTableView.isScrollEnabled = true
            }
            self.view.layoutIfNeeded()
        }
        return true
    }
    
    func mapView(_ mapView: GMSMapView,
                 didChange position: GMSCameraPosition) {
        MarkersProvider.shared.setMarkers()
    }
}
