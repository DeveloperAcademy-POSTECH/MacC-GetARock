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
    
    let coordinate = CLLocationCoordinate2D(
        latitude: 36.014,
        longitude: 129.32
    )
    
    let coordinateRange = 0.03
    let locationManager = CLLocationManager()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        
        self.locationManager.requestWhenInUseAuthorization()
        addAnnotationOnMapView()
        mapView.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: CustomAnnotationView.className)
    }
    
    // MARK: - Method
    
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
            title: "설정에서 위치 정보 권한을 변경해주세요",
            message: "위치정보 제공을 허용하면 현재 위치를 기준으로 장소를 보여줄 수 있어요",
            preferredStyle: .alert
        )
        
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
    
}

// MARK: - CLLocationManagerDelegate

extension MainMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation as? MKUserLocation != nil {
            return MKUserLocationView()
        }
        
        guard let marker = mapView.dequeueReusableAnnotationView(withIdentifier: CustomAnnotationView.className) as? CustomAnnotationView else {
            return CustomAnnotationView()
        }
        
        return marker
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let selectedAnnotation = view.annotation
        let placeName = selectedAnnotation?.title
        
        // TODO: 머피가 반모달 연결할 곳
        let testAlert = UIAlertController(title: placeName!, message: "짜잔", preferredStyle: .alert)
        testAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(testAlert, animated: true, completion: nil)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        // TODO: 핀 선택 취소하면(지도에서 다른 부분 선택하면) 반모달 내려야 함
    }
    
}
