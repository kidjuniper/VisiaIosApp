//
//  MapViewProviderProtocol.swift
//  VisiaGoogle
//
//  Created by Nikita Stepanov on 17.11.2023.
//

import Foundation
import GoogleMaps

protocol MapViewProviderProtocol: AnyObject {
    func setUpMap(view: UIView, complition: (GMSMapView) -> Void)
}
