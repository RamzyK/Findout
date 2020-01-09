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
    var categoryId : String = ""
    
    var bottomSheetView = UIView()
    var blurEffectView = UIVisualEffectView()
    var bottomSheetShowed = false
    var bottomSheetExtanded = false
    var segmentedController: UISegmentedControl!
    var locationManager = CLLocationManager()
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
        l.isUserInteractionEnabled = true
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
    
    var placeStreetLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .left
        l.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        l.font = UIFont(name: "Avenir-Medium", size: 18)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    var placeRegionLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .left
        l.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        l.font = UIFont(name: "Avenir-Medium", size: 18)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    var placeCountryLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .left
        l.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        l.font = UIFont(name: "Avenir-Medium", size: 18)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    var placeRating: UILabel = {
        let l = UILabel()
        l.text = "5"
        l.textAlignment = .left
        l.textColor = #colorLiteral(red: 0.9432621598, green: 0.7699561715, blue: 0.05890782923, alpha: 1)
        l.font = UIFont(name: "Avenir-Medium", size: 18)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    var ratingStar: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(named: "star")
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    var bookingButton: UIButton = {
       let b = UIButton()
        b.backgroundColor = #colorLiteral(red: 0.3276026845, green: 0.784994781, blue: 0.4816099405, alpha: 1)
        b.isUserInteractionEnabled = true
        b.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 20)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(bookPlace), for: .touchUpInside)
        return b
    }()
    
    var shareButton: UIButton = {
       let b = UIButton()
        b.isUserInteractionEnabled = true
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(sharePlaceAdress(sender:)), for: .touchUpInside)
        return b
    }()
    
    var showUserPositionOnMap: UIButton = {
       let b = UIButton()
        b.isUserInteractionEnabled = true
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(showUserCurrentLocaton), for: .touchUpInside)
        return b
    }()
    
    var placeDisponitbilitiesTitle: UILabel = {
        let l = UILabel()
        l.text = NSLocalizedString("places.timeLabel", comment: "")
        l.textAlignment = .left
        l.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        l.font = UIFont(name: "Avenir-Medium", size: 15)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    var placeDisponobolitiesStartTime: UILabel = {
        let l = UILabel()
        l.text = "Dimanche - Lundi"
        l.textAlignment = .left
        l.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        l.font = UIFont(name: "Avenir-Medium", size: 18)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    var placeDisponobolitiesEndTime: UILabel = {
        let l = UILabel()
        l.text = "12:00 - 23:00"
        l.textAlignment = .right
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
    
    var segmentedController: UISegmentedControl!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        askUserForLocation()
        self.map.delegate = self
        closeBottomSheet.addTarget(self, action: #selector(hideBottomSheet(_:)), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openAddPlace))
        print("phase 2 \(categoryId)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        self.placesServices.getAll { (placeList) in
//            self.places = placeList
//        }
        PlaceAPIService.default.getById(id: categoryId) { (place) in
            self.places = place
        }
        self.setBottomSheetViewcConstraint()
        self.setBottomSheetViewsConstraints()
        self.setSegmentedControllerConstraints()
        self.setLocalizeUserButton()
    }
    
    @objc func bookPlace(){
        print("Booked!")
        // TODO
        //self.navigationController?.pushViewController(BookingPage(), animated: true)
    }
    
    @objc func sharePlaceAdress(sender: UIView){
        hideBottomSheet()
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        let textToShare = "Regarde cet endroit sur Findout, il a l'air cool !"

        if let myWebsite = URL(string: "http://www.google.fr") {//Enter link to your app here
            let objectsToShare = [textToShare, myWebsite, image ?? #imageLiteral(resourceName: "app-logo")] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

            //Excluded Activities
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            activityVC.popoverPresentationController?.sourceView = sender
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    @objc func showUserCurrentLocaton(){
        self.map.zoomToUserLocation()
    }
    
    @objc func closeBottomSheet(_ sender: UIButton){
       hideBottomSheet()
    }
    
    @objc func switchView(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("1er filtre")
            break
        case 1:
            print("2eme filtre")
            break
        default:
            break
        }
    }
    
    @objc func showMoreOnBottomSheet() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .showHideTransitionViews, animations: {
            if(self.bottomSheetExtanded){
                self.bottomSheetView.frame.origin.y += (self.view.frame.height/3)
                self.blurEffectView.frame.origin.y += (self.view.frame.height/3)
                self.bottomSheetExtanded = false
            }else{
                self.bottomSheetView.frame.origin.y -= (self.view.frame.height/3)
                self.blurEffectView.frame.origin.y -= (self.view.frame.height/3)
                self.bottomSheetExtanded = true
            }
        }, completion: nil)
    }
    
    private func askUserForLocation(){
        map.showsUserLocation = true
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    private func setSegmentedControllerConstraints(){
        let navigationBarY = Int((self.navigationController?.navigationBar.frame.origin.y)!) + Int((self.navigationController?.navigationBar.frame.height)!)
        let segmentedControllerWidth = Int(self.view.frame.width - 140)
        
        let items = ["< 5 km", "All"]
        segmentedController = UISegmentedControl(items: items)
        segmentedController.addTarget(self, action: #selector(switchView), for: .valueChanged)
        segmentedController.selectedSegmentIndex = 0
        segmentedController.frame = CGRect(x: 70, y: navigationBarY + 20,
                                width: segmentedControllerWidth, height: 40)
        segmentedController.layer.cornerRadius = 5.0
        segmentedController.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        segmentedController.tintColor = UIColor.secondarySystemBackground
        self.view.addSubview(segmentedController)
    }
    
    private func setLocalizeUserButton(){
        let navigationBarY = Int((self.navigationController?.navigationBar.frame.origin.y)!) + Int((self.navigationController?.navigationBar.frame.height)!)
        let buttonOriginX = segmentedController.frame.origin.x + segmentedController.frame.width
        
        let localizeUserView = UIView()
        localizeUserView.frame = CGRect(x: Int(buttonOriginX), y: navigationBarY + 20, width: 70, height: 40)
        
        showUserPositionOnMap.setBackgroundImage(UIImage(systemName: "location.fill"), for: .normal)
        
        localizeUserView.addSubview(showUserPositionOnMap)
        self.view.addSubview(localizeUserView)
        NSLayoutConstraint.activate([
            showUserPositionOnMap.centerXAnchor.constraint(equalTo: localizeUserView.centerXAnchor),
            showUserPositionOnMap.centerYAnchor.constraint(equalTo: localizeUserView.centerYAnchor),
            
            showUserPositionOnMap.widthAnchor.constraint(equalToConstant: 30.0),
            showUserPositionOnMap.heightAnchor.constraint(equalToConstant: 30.0),
        ])
    }
    
    @objc func openAddPlace() {
        self.navigationController?.pushViewController(AddPlaceViewController(), animated: true)
    }
    
    private func setBottomSheetView(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        bottomSheetView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: view.frame.height)
        bottomSheetView.backgroundColor = .clear
        blurEffectView.frame = bottomSheetView.frame
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        bottomSheetView.layer.cornerRadius = 15;
        blurEffectView.layer.cornerRadius = 15;
        bottomSheetView.layer.masksToBounds = true;
        blurEffectView.layer.masksToBounds = true;
        
        self.view.addSubview(blurEffectView)
        self.view.addSubview(bottomSheetView)
    }
    
    private func hideBottomSheet(){
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
    
    private func setPlaceAdress(index: Int){
        self.placeName.text = self.places[index].name
        self.placeStreetLabel.text = self.places[index].address[0]
        self.placeRegionLabel.text = self.places[index].address[1]
        self.placeCountryLabel.text = self.places[index].address[2]
        self.placeRating.text = Int.random(in: 0...5).description
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
        
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        let button = UIButton(type: .infoLight)
        
        guard let placeAnnotation = annotation as? PlaceAnnotation else {
            return nil
        }
        
        let r = placeAnnotation.place
        let index = self.places.firstIndex { $0.id == r.id }
        pin.pinTintColor = .red
        pin.canShowCallout = true
        pin.rightCalloutAccessoryView = button
        button.tag = index!
        button.addTarget(self, action: #selector(touchCallout(sender:)), for: .touchUpInside)
        pin.rightCalloutAccessoryView = button
        
        return pin
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let placeAnnotation = view.annotation as? PlaceAnnotation {
            let r = placeAnnotation.place
            let index = self.places.firstIndex { $0.id == r.id }
            self.showBottomSheet()
            self.map.zoomToLocation(location: placeAnnotation.coordinate)
            setPlaceAdress(index: index!)
        }
    }
    
    @objc func touchCallout(sender: UIButton){
        setPlaceAdress(index: sender.tag)
        self.showBottomSheet()
    }
}

extension PlacesScreenViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
}

extension MKMapView {
  func zoomToUserLocation() {
     self.zoomToUserLocation(latitudinalMeters: 120, longitudinalMeters: 130)
  }

  func zoomToUserLocation(latitudinalMeters:CLLocationDistance,longitudinalMeters:CLLocationDistance)
  {
    guard let coordinate = userLocation.location?.coordinate else { return }
    self.zoomToLocation(location: coordinate, latitudinalMeters: latitudinalMeters, longitudinalMeters: longitudinalMeters)
  }

  func zoomToLocation(location : CLLocationCoordinate2D,latitudinalMeters:CLLocationDistance = 6000,longitudinalMeters:CLLocationDistance = 6000)
  {
    let region = MKCoordinateRegion(center: location, latitudinalMeters: latitudinalMeters, longitudinalMeters: longitudinalMeters)
    setRegion(region, animated: true)
  }

}
