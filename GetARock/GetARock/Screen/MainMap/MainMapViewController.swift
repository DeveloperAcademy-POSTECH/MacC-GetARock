//
//  MainMapViewController.swift
//  GetARock
//
//  Created by Mijoo Kim on 2022/11/17.
//

import CoreLocation
import MapKit
import UIKit

final class MainMapViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var createEventButton: UIButton!
    @IBOutlet weak var attendedEventListButton: UIButton!
    @IBOutlet weak var myPageButton: UIButton!
    
    let coordinate = CLLocationCoordinate2D(
        latitude: 36.014,
        longitude: 129.32
    )

    let coordinateRange = 0.03
    let locationManager = CLLocationManager()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMapView()
        addAnnotationOnMapView()
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    // MARK: - Method
    
    private func setMapView() {
        mapView.delegate = self
        locationManager.delegate = self
        mapView.register(AnnotationView.self, forAnnotationViewWithReuseIdentifier: AnnotationView.className)
    }
    
    private func addAnnotationOnMapView() {
        for band in MockData.bands {
            let point = CustomAnnotation(
                title: band.band.name,
                coordinate: band.band.location.coordinate.toCLLocationCoordinate2D(),
                category: .band
            )
            mapView.addAnnotation(point)
        }
        for gathering in MockData.gatherings {
            let point = CustomAnnotation(
                title: gathering.gathering.host.band.name,
                coordinate: gathering.gathering.location.coordinate.toCLLocationCoordinate2D(),
                category: .gathering
            )
            mapView.addAnnotation(point)
        }
    }
    
    private func setDefaultLocation() {
        mapView.setRegion(
            MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(
                    latitudeDelta: coordinateRange,
                    longitudeDelta: coordinateRange
                )
            ),
            animated: true
        )
    }

    private func centerUserLocation() {
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true)
    }
    
    private func requestLocationAuthorizationWhenUserDenied() {
        let alertController = UIAlertController(
            title: "???????????? ?????? ?????? ????????? ??????????????????",
            message: "???????????? ????????? ???????????? ?????? ????????? ???????????? ????????? ????????? ??? ?????????",
            preferredStyle: .alert
        )
        
        let settingsAction = UIAlertAction(title: "??????", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (_) in
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "??????", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func moveToUserLocation(_ sender: Any) {
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            centerUserLocation()
        case .restricted, .denied:
            requestLocationAuthorizationWhenUserDenied()
        default:
            break
        }
    }
    
}

// MARK: - CLLocationManagerDelegate

extension MainMapViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            centerUserLocation()
            manager.startUpdatingLocation()
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        default:
            setDefaultLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations.last
        
        CLGeocoder().reverseGeocodeLocation(
            currentLocation!,
            completionHandler: {(placemarks, _) -> Void in
                guard let currentPlacemark = placemarks?.first else { return }
                var address: String = ""
                if currentPlacemark.locality != nil {
                    address += " "
                    address += currentPlacemark.locality!
                }
                if currentPlacemark.thoroughfare != nil {
                    address += " "
                    address += currentPlacemark.thoroughfare!
                }
                
                self.locationLabel.text = address
            }
        )
    }

}

// MARK: - CLLocationManagerDelegate

extension MainMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return MKUserLocationView()
        }
        
        guard let marker = mapView.dequeueReusableAnnotationView(withIdentifier: AnnotationView.className) as? AnnotationView else {
            return AnnotationView()
        }
        
        return marker
    }
}
