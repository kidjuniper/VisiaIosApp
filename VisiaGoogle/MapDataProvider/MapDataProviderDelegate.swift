//
//  MapDataProviderProtocol.swift
//  VisiaGoogle
//
//  Created by Nikita Stepanov on 16.11.2023.
//

import Foundation
import GoogleMaps

protocol MapDataProviderDelegate: AnyObject {
    func setSelfAsDelegate(_ manager: CLLocationManager)
}
