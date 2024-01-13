//
//  Marker.swift
//  VisiaGoogle
//
//  Created by Nikita Stepanov on 17.11.2023.
//

import Foundation
import GoogleMaps

class Marker: GMSMarker {
    required init(position: CLLocationCoordinate2D
//         title: String,
//         subTitle: String,
//         icon: UIImage
    ) {
        super.init()
        self.position = position
        self.isFlat = true
//        self.title = title
//        self.snippet = subTitle
//        self.appearAnimation = .pop
////        self.iconView =
//        self.icon = icon
    }
}
