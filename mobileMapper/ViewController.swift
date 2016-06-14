
//  ViewController.swift
//  MobileMapper
import UIKit
import MapKit
// 41.89374,-87.63533
class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    
    let mobileMakersAnnotation = MKPointAnnotation()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        
        let latitude = 41.89374
        let longitude = -87.63533
        
        
        mobileMakersAnnotation.title = "Mobile Makers Academy"
        mobileMakersAnnotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        mapView.addAnnotation(mobileMakersAnnotation)
        
        //        "Locations"
        dropPinForString("Yosemite National Park")
        dropPinForString("Canyonlands National Park")
        
    }
    
    
    func dropPinForString(address:String) {
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks: [CLPlacemark]?, error: NSError?) in
            for placemark in placemarks! {
                let annotation = MKPointAnnotation()
                annotation.coordinate = (placemark.location?.coordinate)!
                annotation.title = placemark.name
                self.mapView.addAnnotation(annotation)
            }
        }
    }
    
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        
        if annotation.isEqual(mapView.userLocation) {
            return nil
            
        } else if annotation.isEqual(mobileMakersAnnotation) {
            let pin = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
            pin.canShowCallout = true
            pin.image = UIImage(named:"mobilemakers")
            pin.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
            return pin
            
        } else {
            let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            pin.canShowCallout = true
            pin.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
            return pin
        }
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        mapView.setRegion(MKCoordinateRegionMake(view.annotation!.coordinate, MKCoordinateSpanMake(0.05, 0.05)), animated: true)
    }
    
    
}
    