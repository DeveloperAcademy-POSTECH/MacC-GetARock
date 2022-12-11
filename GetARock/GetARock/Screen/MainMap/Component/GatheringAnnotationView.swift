//
//  CustomAnnotationView.swift
//  GetARock
//
//  Created by Mijoo Kim on 2022/12/12.
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
  let image = UIImage(named: "GatheringLocation")
  let coordinate: CLLocationCoordinate2D
  let title: String?
  let gatheringInfo: GatheringInfo?

  init(
    coordinate: CLLocationCoordinate2D,
    title: String?,
    gatheringInfo: GatheringInfo?
  ) {
    self.coordinate = coordinate
    self.title = title
    self.gatheringInfo = gatheringInfo

    super.init()
  }

}
