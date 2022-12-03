//
//  Coordinate.swift
//  GetARock
//
//  Created by 김수진 on 2022/11/18.
//

import MapKit

struct Coordinate: Codable {
    typealias LocationDegrees = Double
    
    var latitude: LocationDegrees
    var longitude: LocationDegrees
}

extension Coordinate {
    
    func toCLLocationCoordinate2D() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
    
}
