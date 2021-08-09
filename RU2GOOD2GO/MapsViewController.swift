//
//  MapsViewController.swift
//  RU2GOOD2GO
//
//  Created by Vinayak Talla on 7/26/21.
//

import UIKit
import MapKit

class MapsViewController: UIViewController, CLLocationManagerDelegate, UISearchBarDelegate {
    
    var resultSearchController: UISearchController? = nil
    var selectedPin: MKPlacemark? = nil
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        mapView.delegate = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()

        // Do any additional setup after loading the view.
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! MapsTableViewController
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable as! UISearchResultsUpdating
        
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
        
        let searchBar = resultSearchController!.searchBar
       // searchBar.sizeToFit()
        searchBar.placeholder = "Search your favorite restaurants"
        
        //navigationItem.titleView = resultSearchController?.searchBar
        
        view.addSubview(searchBar)
        
        searchBar.frame = CGRect(x: 0, y: 90, width: 120, height: 25)
       
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.obscuresBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        
        
    }
    
    
    
    func locationManager(manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
                locationManager.requestLocation()
            }
        }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.first {
                let coordinateSpan = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
                let coordinateRegion = MKCoordinateRegion(center: location.coordinate, span: coordinateSpan)
                mapView.centerCoordinate = location.coordinate
                mapView.setRegion(coordinateRegion, animated: true)
                
            }
        }

   
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Failed to get users location.")
        }
    
    

}

extension MapsViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnoationView")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
        }
        
        if annotation === mapView.userLocation {
            return nil
        }
        
        else {
       
        annotationView?.image = UIImage(named: "pin")
            
        // Cutomzime pin size
        //annotationView?.frame.size = CGSize(width: 30, height: 40)
            
        annotationView?.canShowCallout = true
        }
            
        
    
        return annotationView
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        // Use Google Places API here
        print("Annotation was selected")
    }
}

protocol HandleMapSearch {
    func dropPinZoomIn(placemark: MKPlacemark)
}

extension MapsViewController : HandleMapSearch
{
    func dropPinZoomIn(placemark: MKPlacemark) {
        selectedPin = placemark
        
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        annotation.subtitle = placemark.title
        
        mapView?.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
    }
}
