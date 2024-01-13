//
//  Markers.swift
//  VisiaGoogle
//
//  Created by Nikita Stepanov on 17.11.2023.
//

import Foundation
import GoogleMaps

class MarkersProvider: MarkersProviderProtocol {
    
    static var shared = MarkersProvider()
    private var mapProvider = MapDataProvider.shared
    private var markerState = false
    private var markerStateClose = false
    required init() {
        // later here will be added network provider
    }
    func markersArray(_ complition: ([Marker]) -> Void) {
        
    }
    func setMarkers() {
        if !markerState {
            mapProvider.clearMap()
            mapProvider.addMarketsToMap()
            markerState = true
            markerStateClose = false
        }
    }
    func setMarkersClose() {
        if !markerStateClose {
            mapProvider.clearMap()
            mapProvider.addMarketsToMapClose()
            markerStateClose = true
            markerState = false
        }
    }
    
    func resetMarkers() {
        mapProvider.clearMap()
        markerState = false
        markerStateClose = false
    }
    
}


extension MarkersProvider {
    // MARK: временное говно для тестов
    func temproraryMarketsFar(_ complition: ([Marker]) -> Void) {
        let marker = Marker(position: CLLocationCoordinate2D(latitude: 43.002769, longitude: 41.022074))
        marker.title = "Кафе \"Сухум1\""
        marker.iconView = MarketIconView(image: UIImage(named: "Image"))
        marker.appearAnimation = .pop
        marker.snippet = "სოხუმი"
        let marker2 = Marker(position: CLLocationCoordinate2D(latitude: 43.003569, longitude: 41.026074))
        marker2.title = "Кафе \"Сухум2\""
        marker2.iconView = MarketIconView(image: UIImage(named: "Image"))
        marker2.appearAnimation = .pop
        marker2.snippet = "სოხუმი"
        let marker3 = Marker(position: CLLocationCoordinate2D(latitude: 43.003269, longitude: 41.056074))
        marker3.title = "Кафе \"Сухум3\""
        marker3.iconView = MarketIconView(image: UIImage(named: "Image"))
        marker3.appearAnimation = .pop
        marker3.snippet = "სოხუმი"
        let marker4 = Marker(position: CLLocationCoordinate2D(latitude: 43.003469, longitude: 41.016074))
        marker4.title = "Кафе \"Сухум4\""
        marker4.iconView = MarketIconView(image: UIImage(named: "Image"))
        marker4.appearAnimation = .pop
        marker4.snippet = "სოხუმი"
        complition([marker, marker2, marker3, marker4])
    }
    func temproraryMarketsListClose(_ complition: ([Marker]) -> Void) {
        let marker = Marker(position: CLLocationCoordinate2D(latitude: 43.002769, longitude: 41.022074))
        marker.title = "Кафе \"Сухум1\""
        marker.iconView = MarketIconViewClose(image: UIImage(named: "Image"))
        marker.appearAnimation = .pop
        marker.snippet = "სოხუმი"
        let marker2 = Marker(position: CLLocationCoordinate2D(latitude: 43.003569, longitude: 41.026074))
        marker2.title = "Кафе \"Сухум2\""
        marker2.iconView = MarketIconViewClose(image: UIImage(named: "Image"))
        marker2.appearAnimation = .pop
        marker2.snippet = "სოხუმი"
        let marker3 = Marker(position: CLLocationCoordinate2D(latitude: 43.003269, longitude: 41.056074))
        marker3.title = "Кафе \"Сухум3\""
        marker3.iconView = MarketIconViewClose(image: UIImage(named: "Image"))
        marker3.appearAnimation = .pop
        marker3.snippet = "სოხუმი"
        let marker4 = Marker(position: CLLocationCoordinate2D(latitude: 43.003469, longitude: 41.016074))
        marker4.title = "Кафе \"Сухум4\""
        marker4.iconView = MarketIconViewClose(image: UIImage(named: "Image"))
        marker4.appearAnimation = .pop
        marker4.snippet = "სოხუმი"
        complition([marker, marker2, marker3, marker4])
    }
    func temproraryMarketsList(_ complition: ([Marker]) -> Void) {
        let marker = Marker(position: CLLocationCoordinate2D(latitude: 43.002769, longitude: 41.022074))
        marker.title = "Кафе \"Сухум1\""
        marker.iconView = MarketIconView(image: UIImage(named: "Image"))
        marker.appearAnimation = .pop
        marker.snippet = "სოხუმი"
        let marker2 = Marker(position: CLLocationCoordinate2D(latitude: 43.003569, longitude: 41.026074))
        marker2.title = "Кафе \"Сухум2\""
        marker2.iconView = MarketIconView(image: UIImage(named: "Image"))
        marker2.appearAnimation = .pop
        marker2.snippet = "სოხუმი"
        let marker3 = Marker(position: CLLocationCoordinate2D(latitude: 43.003269, longitude: 41.056074))
        marker3.title = "Кафе \"Сухум3\""
        marker3.iconView = MarketIconView(image: UIImage(named: "Image"))
        marker3.appearAnimation = .pop
        marker3.snippet = "სოხუმი"
        let marker4 = Marker(position: CLLocationCoordinate2D(latitude: 43.003469, longitude: 41.016074))
        marker4.title = "Кафе \"Сухум4\""
        marker4.iconView = MarketIconView(image: UIImage(named: "Image"))
        marker4.appearAnimation = .pop
        marker4.snippet = "სოხუმი"
        let marker5 = Marker(position: CLLocationCoordinate2D(latitude: 43.005499, longitude: 41.006074))
        marker5.title = "Кафе \"Сухум5\""
        marker5.iconView = MarketIconView(image: UIImage(named: "Image"))
        marker5.appearAnimation = .pop
        marker5.snippet = "სოხუმი"
        let marker6 = Marker(position: CLLocationCoordinate2D(latitude: 43.003009, longitude: 41.015174))
        marker6.title = "Кафе \"Сухум6\""
        marker6.iconView = MarketIconView(image: UIImage(named: "Image"))
        marker6.appearAnimation = .pop
        marker6.snippet = "სოხუმი"
        complition([marker, marker2, marker3, marker4, marker5, marker6])
    }
}
