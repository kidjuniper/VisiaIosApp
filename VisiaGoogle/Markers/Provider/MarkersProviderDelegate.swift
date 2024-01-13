//
//  MarketsProviderDelegate.swift
//  VisiaGoogle
//
//  Created by Nikita Stepanov on 17.11.2023.
//

import Foundation
import GoogleMaps

protocol MarkersProviderDelegate {
    func addMarketsToMap()
    func addMarketsToMapClose()
    func clearMap()
}
