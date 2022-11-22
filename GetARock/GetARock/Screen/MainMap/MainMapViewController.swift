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
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var createEventButton: UIButton!
    @IBOutlet weak var attendedEventListButton: UIButton!
    @IBOutlet weak var myPageButton: UIButton!
    
    var coordinate = CLLocationCoordinate2D(
        latitude: 36.014,
        longitude: 129.32
    )

    let coordinateRange = 0.03
    let locationManager = CLLocationManager()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
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
    
    // MARK: - Method
    
    private func centerUserLocation() {
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true)
    }
    
    private func requestLocationAuthorizationWhenUserDenied() {
        let alertController = UIAlertController(title: "설정에서 위치 정보 권한을 변경해주세요", message: "위치정보 제공을 허용하면 현재 위치를 기준으로 장소를 보여줄 수 있어요", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "설정", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (_) in
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "취소", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func moveToUserLocation(_ sender: Any) {
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            centerUserLocation()
        case .restricted, .denied:
            requestLocationAuthorizationWhenUserDenied()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            setDefaultLocation()
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
            setDefaultLocation()
        default:
            setDefaultLocation()
        }
    }
    
}
