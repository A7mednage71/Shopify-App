//
//  File.swift
//  
//
//  Created by Eyad waleed on 05/07/2026.
//

import Foundation
import CoreLocation

struct SelectedAddress {
    var fullAddress: String = ""
    var zipCode: String = ""
    var country: String = ""
    var city : String = ""
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
}
