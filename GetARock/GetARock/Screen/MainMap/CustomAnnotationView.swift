//
//  CustomAnnotationView.swift
//  GetARock
//
//  Created by Mijoo Kim on 2022/11/23.
//

import MapKit
import UIKit

class CustomAnnotationView: MKMarkerAnnotationView {
    
    override func draw(_ rect: CGRect) {
        guard let annotation = annotation as? CustomAnnotation else {
            super.draw(rect)
            return
        }
        
        glyphImage = annotation.category.image
        glyphTintColor = .white
        markerTintColor = annotation.category.pinColor
        
        super.draw(rect)
    }
    
}

class CustomAnnotation: NSObject, MKAnnotation {
    
    enum Category {
        case band
        case gathering
        
        var image: UIImage {
            switch self {
            case .band:
                return UIImage(systemName: "music.note") ?? UIImage()
            case .gathering:
                return UIImage(systemName: "music.note") ?? UIImage()
            }
        }
        
        var pinColor: UIColor {
            switch self {
            case .band: return .mainPurple
            case .gathering: return .subBlue
            }
        }
    }
    
    let title: String?
    let coordinate: CLLocationCoordinate2D
    let category: Category
    
    init(title: String?, coordinate: CLLocationCoordinate2D, category: Category) {
        self.title = title
        self.coordinate = coordinate
        self.category = category
    }
}
