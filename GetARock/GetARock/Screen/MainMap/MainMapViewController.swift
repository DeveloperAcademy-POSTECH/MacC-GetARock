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
    
    var nextViewController: UIViewController?
    
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
        mapView.register(BandAnnotationView.self,
                         forAnnotationViewWithReuseIdentifier: BandAnnotationView.className)
        mapView.register(GatheringAnnotationView.self,
                         forAnnotationViewWithReuseIdentifier: GatheringAnnotationView.className)
    }
    
    private func addAnnotationOnMapView() {
        addBandAnnotationOnMapView()
        addGatheringAnnotationOnMapView()
    }
    
    private func addBandAnnotationOnMapView() {
        let points = MockData.bands.map {
            BandAnnotation(
                title: $0.band.name,
                coordinate: $0.band.location.coordinate.toCLLocationCoordinate2D(),
                bandInfo: $0
            )
        }
        mapView.addAnnotations(points)
    }
    
    private func addGatheringAnnotationOnMapView() {
        let points = MockData.gatherings.map {
            GatheringAnnotation(
                title: $0.gathering.host.band.name,
                coordinate: $0.gathering.location.coordinate.toCLLocationCoordinate2D(),
                gatheringInfo: $0
            )
        }
        mapView.addAnnotations(points)
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
    
    @IBAction func createEventButtonClicked(_ sender: UIButton) {
        let addGatheringViewController = UIStoryboard(
            name: "AddGathering",
            bundle: nil
        ).instantiateViewController(withIdentifier: AddGatheringViewController.className)
        addGatheringViewController.modalPresentationStyle = .pageSheet
        if let sheet = addGatheringViewController.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
        }
        nextViewController = addGatheringViewController
        present(addGatheringViewController, animated: true, completion: nil)
    }
    
    @IBAction func attendedEventListButtonClicked(_ sender: UIButton) {
        let gatheringListViewController = GatheringListTapViewController()
        gatheringListViewController.modalPresentationStyle = .pageSheet
        if let sheet = gatheringListViewController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.largestUndimmedDetentIdentifier = .medium
        }
        nextViewController = gatheringListViewController
        present(gatheringListViewController, animated: true, completion: nil)
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

// MARK: - MKMapViewDelegate

extension MainMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return MKUserLocationView()
        } else if annotation is BandAnnotation {
            return mapView.dequeueReusableAnnotationView(withIdentifier: BandAnnotationView.className)
        } else if annotation is GatheringAnnotation {
            return mapView.dequeueReusableAnnotationView(withIdentifier: GatheringAnnotationView.className)
        } else {
            return nil
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if view.annotation is GatheringAnnotation {
            guard let selectedAnnotation = view.annotation as? GatheringAnnotation else { return }
            _ = selectedAnnotation.title
            
        if selectedAnnotation is GatheringAnnotation {
            guard let gatheringViewController = UIStoryboard(
                name: "GatheringInfoPage",
                bundle: nil
            ).instantiateViewController(
                withIdentifier: GatheringInfoViewController.className
            ) as? GatheringInfoViewController else { return }
            gatheringViewController.modalPresentationStyle = .pageSheet
            if let sheet = gatheringViewController.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.prefersGrabberVisible = true
                sheet.largestUndimmedDetentIdentifier = .medium
            }
            nextViewController = gatheringViewController
            present(gatheringViewController, animated: true, completion: nil)
        }else if view.annotation is BandAnnotation {
            guard let selectedAnnotation = view.annotation as? BandAnnotation else { return }
            _ = selectedAnnotation.title
            
            let bandViewController = BandPageViewController()
            bandViewController.modalPresentationStyle = .pageSheet
            if let sheet = bandViewController.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.prefersGrabberVisible = true
                sheet.largestUndimmedDetentIdentifier = .medium
            }
            nextViewController = bandViewController
            present(bandViewController, animated: true, completion: nil)
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        nextViewController?.dismiss(animated: true)
    }
    
}
