//
//  MapDataProvider.swift
//  VisiaGoogle
//
//  Created by Nikita Stepanov on 16.11.2023.
//

import Foundation
import GoogleMaps
import Alamofire
import SwiftyJSON

//
class MapDataProvider: MapViewProviderProtocol {
    
    var locationManager: CLLocationManager?
    var currentLocation: CLLocation?
    var mapView: GMSMapView?
    var preciseLocationZoomLevel: Float = 15.5
    var approximateLocationZoomLevel: Float = 10.5
    var mapController: MapDataProviderDelegate = MapViewController()
    
    static let shared = MapDataProvider()
    
    required init() {
        locationManager = CLLocationManager()
        mapController.setSelfAsDelegate(locationManager!)
    }
    // MARK: main provider function
    func setUpMap(view: UIView, complition: (GMSMapView) -> Void) {
        // camera settings
        let defaultLocation = CLLocation(latitude: 43.001327,
                                         longitude: 41.023216)
        let zoomLevel = locationManager!.accuracyAuthorization == .fullAccuracy ? preciseLocationZoomLevel : approximateLocationZoomLevel
        let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude,
                                              longitude: defaultLocation.coordinate.longitude,
                                              zoom: zoomLevel)
        mapView = GMSMapView.map(withFrame: view.bounds,
                                 camera: camera)
        setUpMap() // some more settings
        complition(mapView!)
    }
    // style and adding user's location
    func setUpMap() {
        do {
            if let styleURL = Bundle.main.url(forResource: "mapStyle",
                                              withExtension: "json") {
                self.mapView?.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                print("Unable to find mapStyle.json")
            }
        } catch {
            print("One or more of the map styles failed to load. \(error)")
        }
        DispatchQueue.main.async {
            if self.locationManager?.authorizationStatus == .authorizedAlways || self.locationManager?.authorizationStatus == .authorizedWhenInUse {
                self.locationManager?.requestLocation()
                self.mapView?.isMyLocationEnabled = true
                self.mapView?.settings.myLocationButton = true
            } else {
                self.locationManager?.requestWhenInUseAuthorization()
            }
        }
    }
}

extension MapDataProvider: MarkersProviderDelegate {
    // adding
    func addMarketsToMap() {
        markers()
    }
    
    func addMarketsToMapClose() {
        marketsClose()
    }
    func markers() {
        MarkersProvider.shared.temproraryMarketsList() { markets in
            for i in markets {
                i.map = mapView
            }
        }
    }
    func marketsClose() {
        MarkersProvider.shared.temproraryMarketsListClose { markets in
            for i in markets {
                i.map = mapView
            }
        }
    }
    
    // removing
    func clearMap() {
        mapView?.clear()
    }
}

extension MapDataProvider {
    func route(from sourceLocation: GMSMarker,
               to destinationLocation: GMSMarker,
               numberOfRoutes: Int) {
        let sourceLat = sourceLocation.position.latitude
        let sourceLng = sourceLocation.position.longitude
        let destinationLat = destinationLocation.position.latitude
        let destinationlng = destinationLocation.position.longitude
        let sourceLocation = "\(sourceLat), \(sourceLng)"
        let destinationlocation = "\(destinationLat), \(destinationlng)"
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(sourceLocation)&destination=\(destinationlocation)&mode=driving&key=AIzaSyCiDTx6VsMz8QhS-3Za6g7icJiPySgRbH0"
        
        let request = AF.request(url)
        request.responseJSON { (response) in
            guard let data = response.data else {
                return
            }
            do {
                let jsonData = try JSON(data: data)
                let routes = jsonData["routes"].arrayValue
                print(jsonData)
                for route in routes {
                    let overviewPolyline = route["overview_polyline"].dictionary
                    let points = overviewPolyline?["points"]?.string
                    let path = GMSPath.init(fromEncodedPath: points ?? "")
                    let polyline = GMSPolyline.init(path: path)
                    polyline.strokeColor = UIColor.link.withAlphaComponent(0.3 + 0.7/CGFloat(numberOfRoutes))
                    polyline.strokeWidth = 5
                    polyline.geodesic = true
                    polyline.map = self.mapView
                    RouteHolder.shared.currentPolylines.append(polyline)
                }
            }
            catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
