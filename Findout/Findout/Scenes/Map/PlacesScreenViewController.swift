//
//  PlacesScreenViewController.swift
//  Findout
//
//  Created by Ramzy Kermad on 19/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import UIKit
import MapKit
import Photos

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
    var bottomSheetConstrainsDone = false
    
    var bottomSheetView = UIView()
    var blurEffectView = UIVisualEffectView()
    var bottomSheetShowed = false
    var bottomSheetExtanded = false
    var segmentedController: UISegmentedControl!
    var locationManager = CLLocationManager()
    
    var allPlaces: [PlaceDao] = []
    var places: [PlaceDao] = []{
        didSet{
            self.map.annotations.forEach {
              if !($0 is MKUserLocation) {
                self.map.removeAnnotation($0)
              }
            }
            
            if(self.places.count > 0){
                self.map.addAnnotations(
                    self.places.map({
                        PlaceAnnotation(place: $0)
                    })
                )
            }
        }
    }
    var placesServices: PlaceServices{
        return PlaceAPIService()
    }
    
    var indexForBook : Int = 0
    
    // views
    var placeImageViewCtn = UIView()
    
    var placeImage: UIImageView = {
        let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.clipsToBounds = true
        i.contentMode = .scaleToFill
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
    
    var placeDisponobolitiesWeekTime: UILabel = {
        let l = UILabel()
        l.text = NSLocalizedString("place.weekDays", comment: "")
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
    
    var closeBottomSheetBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(named: "close_bottom_sheet"), for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        askUserForLocation()
        self.map.delegate = self
        closeBottomSheetBtn.addTarget(self, action: #selector(closeBottomSheet), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openAddPlace))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let loaderAlert = UIAlertController(title: nil,
                                      message: NSLocalizedString("place.loading", comment: ""),
                                      preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 150, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();

        loaderAlert.view.addSubview(loadingIndicator)
        present(loaderAlert, animated: true, completion: nil)
        PlaceAPIService.default.getByIdCategory(id: categoryId) { (place) in
            loaderAlert.dismiss(animated: true) {
                self.places = place
            }
        }
        self.setBottomSheetView()
        self.setBottomSheetViewsConstraints()
        self.setSegmentedControllerConstraints()
        self.setLocalizeUserButton()
    }
    
    @objc func bookPlace(){
        let userId = "5e033735274cac40da9ed1d4"
        let placeId = self.places[indexForBook].id
        present(ReservationViewController.instance.alert(idPlace : placeId, idUser : userId), animated: true)
    }
    
    @objc func sharePlaceAdress(sender: UIView){
        hideBottomSheet(delta: Int(self.view.frame.height/3))
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
    
    @objc func closeBottomSheet(){
        if(self.bottomSheetExtanded){
            hideBottomSheet(delta: 2 * Int(self.view.frame.height/3))
            self.bottomSheetShowed = false
            self.bottomSheetExtanded = false
        }else{
            if(self.bottomSheetShowed){
                hideBottomSheet(delta:Int(self.view.frame.height/3))
                self.bottomSheetShowed = false
            }
        }
    }
    
    @objc func switchView(sender: UISegmentedControl) {
        guard let userCurrentLocation = map.userLocation.location else { return }
        switch sender.selectedSegmentIndex {
        case 0:
            if(allPlaces.count != 0){
                self.places = allPlaces
            }
            break
        case 1:
            self.places = places.filter({ (place) -> Bool in
                let placeLocation = place.location
                allPlaces.append(place)
                return userCurrentLocation.distance(from: placeLocation)/1000 < 5
            })
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
    
    private func askUserForGaleryPermission(){
        AVCaptureDevice.requestAccess(for: .video) { success in
          if success { // if request is granted (success is true)
          } else { // if request is denied (success is false)
            // Create Alert
            let alert = UIAlertController(title: "Camera", message: "Camera access is absolutely necessary to use this app", preferredStyle: .alert)

            // Add "OK" Button to alert, pressing it will bring you to the settings app
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }))
            // Show the alert with animation
            self.present(alert, animated: true)
          }
        }
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
            askUserForGaleryPermission()
        }
    }
    
    private func setSegmentedControllerConstraints(){
        let navigationBarY = Int((self.navigationController?.navigationBar.frame.origin.y)!) + Int((self.navigationController?.navigationBar.frame.height)!)
        let segmentedControllerWidth = Int(self.view.frame.width - 140)
        
        let items = ["All", "< 5 km"]
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
        AVCaptureDevice.requestAccess(for: .video) { success in
          if success { // if request is granted (success is true)
            DispatchQueue.main.async {
                self.closeBottomSheet()
                self.navigationController?.pushViewController(AddPlaceViewController(), animated: true)
            }
          } else { // if request is denied (success is false)
            // Create Alert
            let alert = UIAlertController(title: "Camera", message: "Camera access is absolutely necessary to use this app", preferredStyle: .alert)

            // Add "OK" Button to alert, pressing it will bring you to the settings app
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }))
            // Show the alert with animation
            self.present(alert, animated: true)
          }
        }

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
    
    @objc private func hideBottomSheet(delta: Int){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .showHideTransitionViews, animations: {
                   if(self.bottomSheetShowed){
                       self.bottomSheetView.frame.origin.y += CGFloat(delta) //(self.view.frame.height/3)
                       self.blurEffectView.frame.origin.y += CGFloat(delta) //(self.view.frame.height/3)
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
        if (!self.bottomSheetConstrainsDone){
            self.setBottomSheetViewsConstraints()
            self.bottomSheetConstrainsDone = true
        }
    }
    
    private func setPlaceAdress(index: Int){
        self.placeName.text = self.places[index].name
        self.placeStreetLabel.text = self.places[index].address[0]
        self.placeRegionLabel.text = self.places[index].address[1]
        self.placeCountryLabel.text = self.places[index].address[2]
        self.placeRating.text = Int.random(in: 0...5).description
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: self.places[index].place_image)) {
                DispatchQueue.main.sync {
                    self.placeImage.image = UIImage(data: data)
                }
            }else{
                DispatchQueue.main.sync {
                    self.placeImage.image = UIImage(named: "image-not-found")
                }
            }
        }
        guard let startDispo = self.places[index].disponibilityStartTime,
            let endDispo = self.places[index].disponibilityEndTime else{
                self.placeDisponobolitiesEndTime.text = "--"
                return
        }
        self.placeDisponobolitiesEndTime.text = startDispo + " - " + endDispo
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
            self.indexForBook = index!
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
