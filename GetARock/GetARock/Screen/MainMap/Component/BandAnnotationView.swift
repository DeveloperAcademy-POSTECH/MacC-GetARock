//
//  CustomAnnotationView.swift
//  GetARock
//
//  Created by Mijoo Kim on 2022/11/23.
//

import MapKit
import UIKit

class BandAnnotationView: MKMarkerAnnotationView {
    
    override func draw(_ rect: CGRect) {
        guard annotation is BandAnnotation else {
            super.draw(rect)
            return
        }
        
        glyphImage = UIImage(systemName: "music.note")
        glyphTintColor = .white
        markerTintColor = .mainPurple
        
        super.draw(rect)
    }
    
}

class BandAnnotation: NSObject, MKAnnotation {
    
    let title: String?
    let coordinate: CLLocationCoordinate2D
    let bandInfo: BandInfo?
    
    init(title: String, coordinate: CLLocationCoordinate2D, bandInfo: BandInfo) {
        self.title = title
        self.coordinate = coordinate
        self.bandInfo = bandInfo
    }
}
