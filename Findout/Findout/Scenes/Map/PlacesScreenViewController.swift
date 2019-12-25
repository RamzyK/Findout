//
//  PlacesScreenViewController.swift
//  Findout
//
//  Created by Ramzy Kermad on 19/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import UIKit
import MapKit

fileprivate class PlaceAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        return self.place.location.coordinate
    }
    var title: String? {
        return self.place.name
    }
    var place: PlaceDao
    
    init(place: PlaceDao) {
        self.place = place
        super.init()
    }
    
}

class PlacesScreenViewController: UIViewController {
    @IBOutlet weak var map: MKMapView!
    
    var places: [PlaceDao] = []{
        didSet{
           self.map.addAnnotations(
                self.places.map({
                    PlaceAnnotation(place: $0)
                })
            )
        }
    }
    
    var placesServices: PlaceServices{
        return PlacesMockServices()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        self.map.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.placesServices.getAll { (placeList) in
            self.places = placeList
        }
    }
    
    func setupNavigationBar() {
        self.title = NSLocalizedString("places.title", comment: "")
        self.navigationController?.navigationBar.topItem?.title = ""
    }
}

extension PlacesScreenViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation {
                return nil
            }
            if let placeAnnotation = annotation as? PlaceAnnotation {
                let r = placeAnnotation.place
                let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
                pin.pinTintColor = .purple
                pin.canShowCallout = true
                let button = UIButton(type: .infoLight)
                let index = self.places.firstIndex { $0.id_place == r.id_place }
    //            let index2 = self.restaurants.firstIndex { (resto) -> Bool in
    //                return resto.id == r.id
    //            }
                button.tag = index ?? -1
                button.addTarget(self, action: #selector(touchCallout(_:)), for: .touchUpInside)
                pin.rightCalloutAccessoryView = button
                return pin
            }
            return nil
        }
        
        @objc func touchCallout(_ sender: UIButton) {
            let place = self.places[sender.tag]
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(place.location) { (placemarks, err) in
                guard err == nil,
                      let adress = placemarks?.first else {
                        return
                }
                print(adress) // Affiche l'adresse
            }
        }
}
