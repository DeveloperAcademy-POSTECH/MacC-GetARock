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
    
    var nextVC: UIViewController?
    
    let coordinate = CLLocationCoordinate2D(
        latitude: 36.014,
        longitude: 129.32
    )

    let coordinateRange = 0.03
    let zoomInRange = 0.015
    let locationManager = CLLocationManager()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enrollLoginObserver()
        setMapView()
        addAnnotationOnMapView()
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Method
    
    private func enrollLoginObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didLogin(_:)),
            name: Notification.Name("ResponedLogin"),
            object: nil
        )
    }
    
    @objc
    private func didLogin(_ sender: Notification) {
        print()
        print("did login - MainMapViewController")
        print()
    }
    
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
                category: .band,
                band: band
                
            )
            mapView.addAnnotation(point)
        }
        for gathering in MockData.gatherings {
            let point = CustomAnnotation(
                title: gathering.gathering.host.band.name,
                coordinate: gathering.gathering.location.coordinate.toCLLocationCoordinate2D(),
                category: .gathering,
                gathering: gathering
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
    
    func focusOnSelectedLocation(latitudeValue: CLLocationDegrees,
                                 longitudeValue: CLLocationDegrees,
                                 delta span: Double) {
        let currentLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        let spanValue = MKCoordinateSpan(latitudeDelta: zoomInRange,
                                         longitudeDelta: zoomInRange)
        let currentRegion = MKCoordinateRegion(center: currentLocation, span: spanValue)
        mapView.setRegion(currentRegion, animated: true)
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
    
    @IBAction func addGetARockButtonClicked(_ sender: UIButton) {
//        let addGatheringViewController = UIStoryboard(name: "AddGathering", bundle: nil).instantiateViewController(withIdentifier: AddGatheringViewController.className)
        let addGatheringViewController = UIStoryboard(name: "AddGathering", bundle: nil).instantiateInitialViewController() ?? UIViewController()
        addGatheringViewController.modalPresentationStyle = .pageSheet
        if let sheet = addGatheringViewController.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
        }
        nextVC = addGatheringViewController
        present(addGatheringViewController, animated: true, completion: nil)
    }
    
    @IBAction func getARockListButtonClicked(_ sender: UIButton) {
        let gatheringListViewController = GatheringListViewController()
        gatheringListViewController.modalPresentationStyle = .pageSheet
        if let sheet = gatheringListViewController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.largestUndimmedDetentIdentifier = .medium
        }
        nextVC = gatheringListViewController
        present(gatheringListViewController, animated: true, completion: nil)
    }
    @IBAction func myPageButtonClicked(_ sender: UIButton) {
        let myPageViewController = BandPageViewController(bandInfo: MockData.bands[0])
        myPageViewController.modalPresentationStyle = .pageSheet
        if let sheet = myPageViewController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.largestUndimmedDetentIdentifier = .medium
        }
        nextVC = myPageViewController
        present(myPageViewController, animated: true, completion: nil)
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
        let currentLocation = locations.last ?? nil
        
        CLGeocoder().reverseGeocodeLocation(
            currentLocation!,
            completionHandler: {(placemarks, _) -> Void in
                let currentPlacemark = placemarks?.first
                var address: String = ""
                if currentPlacemark?.locality != nil {
                    address += " "
                    address += currentPlacemark!.locality!
                }
                if currentPlacemark?.thoroughfare != nil {
                    address += " "
                    address += currentPlacemark!.thoroughfare!
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
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        guard let selectedAnnotation = view.annotation as? CustomAnnotation else { return }
        let placeName = selectedAnnotation.title
        
        focusOnSelectedLocation(latitudeValue: selectedAnnotation.coordinate.latitude - 0.005, longitudeValue: selectedAnnotation.coordinate.longitude, delta: zoomInRange)

        switch selectedAnnotation.category {
        case .band :
            guard let bandData = selectedAnnotation.bandInfo else { return }
            let bandViewController = BandPageViewController(bandInfo: bandData)
            bandViewController.modalPresentationStyle = .pageSheet
            if let sheet = bandViewController.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.prefersGrabberVisible = true
                sheet.largestUndimmedDetentIdentifier = .medium
            }
            nextVC = bandViewController
            present(bandViewController, animated: true, completion: nil)
        case .gathering :
            // guard let gatheringData = selectedAnnotation.gatheringInfo else { return }
            let gatheringViewController = UIStoryboard(name: "GatheringInfoPage", bundle: nil).instantiateViewController(withIdentifier: GatheringInfoViewController.className)
            gatheringViewController.modalPresentationStyle = .pageSheet
            if let sheet = gatheringViewController.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.prefersGrabberVisible = true
                sheet.largestUndimmedDetentIdentifier = .medium
            }
            nextVC = gatheringViewController
            present(gatheringViewController, animated: true, completion: nil)
        }
        
        let testAlert = UIAlertController(title: placeName!, message: "짜잔", preferredStyle: .alert)
        testAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(testAlert, animated: true, completion: nil)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        guard let selectedAnnotation = view.annotation as? CustomAnnotation else {
                   return
               }
        nextVC?.dismiss(animated: true)
        focusOnSelectedLocation(latitudeValue: selectedAnnotation.coordinate.latitude, longitudeValue: selectedAnnotation.coordinate.longitude, delta: zoomInRange)
    }
}
