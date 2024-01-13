//
//  RouteHolder.swift
//  VisiaGoogle
//
//  Created by Nikita Stepanov on 26.11.2023.
//

import Foundation
import GoogleMaps

//
class RouteHolder {
    var stops: [GMSMarker] = []
    var currentPolylines: [GMSPolyline] = []
    var isStartPoint = false
    static var shared: RouteHolder = RouteHolder()
    
    func addNewStop(_ marker: GMSMarker) {
        stops.insert(marker, 
                     at: isStartPoint ? 0 : stops.count)
    }
    func removeStop(_ marker: GMSMarker) {
        stops.removeAll(where: { $0 == marker })
    }
    func drawRoute() {
        clearRoutes()
        for i in 0..<stops.count - 1 {
            MapDataProvider.shared.route(from: stops[i],
                                         to: stops[i+1],
                                         numberOfRoutes: stops.count)
        }
    }
    func removeRoutes() {
        stops = []
        clearRoutes()
    }
    func clearRoutes() {
        currentPolylines.forEach { polyline in
            polyline.map = nil
        }
        currentPolylines = []
    }
}
