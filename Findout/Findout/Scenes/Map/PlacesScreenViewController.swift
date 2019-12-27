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
    
    var bottomSheetView = UIView()
    var blurEffectView = UIVisualEffectView()
    var bottomSheetShowed = false
    
    // views
    var placeImageViewCtn = UIView()
    
    var placeImage: UIImageView = {
        let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
       
    let placeName: UILabel = {
        let l = UILabel()
        l.text = "ESGI"
        l.textAlignment = .left
        l.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        l.font = UIFont(name: "Avenir-Medium", size: 28)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    var placeAdress: UILabel = {
        let l = UILabel()
        l.text = "123 AVENUE DE TA GRAND MÈRE"
        l.textAlignment = .left
        l.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        l.font = UIFont(name: "Avenir-Medium", size: 17)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    var placeRating: UILabel = {
        let l = UILabel()
        l.text = "0/5"
        l.textAlignment = .left
        l.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        l.font = UIFont(name: "Avenir-Medium", size: 18)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    var placeDisponitbilitiesTitle: UILabel = {
        let l = UILabel()
        l.text = "Créneaux"
        l.textAlignment = .left
        l.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        l.font = UIFont(name: "Avenir-Medium", size: 20)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    var placeDisponobolitiesStartTime: UILabel = {
        let l = UILabel()
        l.text = "du Lun au Ven"
        l.textAlignment = .left
        l.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        l.font = UIFont(name: "Avenir-Medium", size: 18)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    var placeDisponobolitiesEndTime: UILabel = {
        let l = UILabel()
        l.text = "à partir de 9h45"
        l.textAlignment = .left
        l.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        l.font = UIFont(name: "Avenir-Medium", size: 18)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    var closeBottomSheet: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(named: "close_bottom_sheet"), for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b;
    }()
    
    
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
        closeBottomSheet.addTarget(self, action: #selector(hideBottomSheet(_:)), for: .touchUpInside)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.placesServices.getAll { (placeList) in
            self.places = placeList
        }
        setBottomSheetView()
        self.setBottomSheetViewsConstraints()

    }
    
    private func setBottomSheetView(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        bottomSheetView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: view.frame.height)
        bottomSheetView.backgroundColor = .clear
        blurEffectView.frame = bottomSheetView.frame
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        bottomSheetView.layer.cornerRadius = 33;
        blurEffectView.layer.cornerRadius = 33;
        bottomSheetView.layer.masksToBounds = true;
        blurEffectView.layer.masksToBounds = true;
        
        self.view.addSubview(blurEffectView)
        self.view.addSubview(bottomSheetView)
        
    }
    
    @objc func hideBottomSheet(_ sender: UIButton){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .showHideTransitionViews, animations: {
            if(self.bottomSheetShowed){
                self.bottomSheetView.frame.origin.y += (self.view.frame.height/3)
                self.blurEffectView.frame.origin.y += (self.view.frame.height/3)
                self.bottomSheetShowed = false
            }
        }, completion: nil)
    }
    
    private func showBottomSheet(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .showHideTransitionViews, animations: {
            if(!self.bottomSheetShowed){
                self.bottomSheetView.frame.origin.y -= (self.view.frame.height/3)
                self.blurEffectView.frame.origin.y -= (self.view.frame.height/3)
                self.bottomSheetShowed = true
            }
        }, completion: nil)
        self.setBottomSheetViewsConstraints()
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
            button.tag = index ?? -1
            button.addTarget(self, action: #selector(touchCallout(_:)), for: .touchUpInside)
            pin.rightCalloutAccessoryView = button
            return pin
        }
        return nil
    }
        
    @objc func touchCallout(_ sender: UIButton) {
        self.placeName.text = self.places[sender.tag].name
        self.placeAdress.text = self.places[sender.tag].address
        self.placeRating.text = Int.random(in: 0...5).description + "/5"
        
        self.showBottomSheet()
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
