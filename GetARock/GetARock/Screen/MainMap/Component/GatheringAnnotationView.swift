//
//  GatheringAnnotationView.swift
//  GetARock
//
//  Created by Mijoo Kim on 2023/01/06.
//

import MapKit
import UIKit

class GatheringAnnotationView: MKAnnotationView {
    
    static let identifier = "GatheringAnnotationView"
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        frame = CGRect(x: 0, y: 0, width: 40, height: 50)
        centerOffset = CGPoint(x: 0, y: -frame.size.height / 2)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
    }
    
}

class GatheringAnnotation: NSObject, MKAnnotation {
  let coordinate: CLLocationCoordinate2D
  let title: String?
  let gatheringInfo: GatheringInfo?

  init(
    title: String,
    coordinate: CLLocationCoordinate2D,
    gatheringInfo: GatheringInfo
  ) {
    self.title = title
    self.coordinate = coordinate
    self.gatheringInfo = gatheringInfo

    super.init()
  }
  
//  init(title: String, coordinate: CLLocationCoordinate2D, gatheringInfo: GatheringInfo) {
//      self.title = title
//      self.coordinate = coordinate
//      self.gatheringInfo = gatheringInfo
//  }

}
