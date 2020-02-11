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
import FanMenu

    // MARK: - ANNOTATION
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
    
    // MARK: - VARIABLES
    var bottomSheetView = UIView()
    var blurEffectView = UIVisualEffectView()
    var segmentedController: UISegmentedControl!
    var locationManager = CLLocationManager()
    var bottomSheetShowed = false
    var bottomSheetExtanded = false
    var categoryId : String = ""
    var bottomSheetConstrainsDone = false
    var indexForBook : Int = 0
    var fanMenu = FanMenu()
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
    
    let userID : String? = UserDefaults.standard.string(forKey: "userID")

   
    
    //MARK: - VIEWS DECLARATION
    
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
        b.backgroundColor = #colorLiteral(red: 0.3294117647, green: 0.784994781, blue: 0.4816099405, alpha: 1)
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
    

    //MARK: - OVERRIDES FUNC
    override func viewWillAppear(_ animated: Bool) {
        self.hideNavigationBar(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setMainButton()
        askUserForLocation()
        self.map.delegate = self
        closeBottomSheetBtn.addTarget(self, action: #selector(closeBottomSheet), for: .touchUpInside)
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
            self.setBottomSheetView()
            self.setBottomSheetViewsConstraints()
            self.setSegmentedController()
            self.setLocalizeUserButton()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.showNavigationBar(animated)
    }
    
    
    // MARK: - MAP
    private func setLocalizeUserButton(){
        let buttonOriginX = Int(self.view.frame.width - 25)
        let buttonOriginY = Int(fanMenu.center.y - 20)
        
        let localizeUserView = UIView()
        localizeUserView.frame = CGRect(x: 0, y: 0, width: 70, height: 200)
        localizeUserView.center = CGPoint(x: buttonOriginX, y: buttonOriginY)
        
        showUserPositionOnMap.setBackgroundImage(UIImage(systemName: "location.circle"), for: .normal)
        
        localizeUserView.addSubview(showUserPositionOnMap)
        self.view.addSubview(localizeUserView)
        NSLayoutConstraint.activate([
            showUserPositionOnMap.centerXAnchor.constraint(equalTo: localizeUserView.centerXAnchor),
            showUserPositionOnMap.centerYAnchor.constraint(equalTo: localizeUserView.centerYAnchor),
            
            showUserPositionOnMap.widthAnchor.constraint(equalToConstant: 30.0),
            showUserPositionOnMap.heightAnchor.constraint(equalToConstant: 30.0),
        ])
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
    
    @objc func showUserCurrentLocaton(){
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = 1

        self.showUserPositionOnMap.layer.add(animation, forKey: CATransitionType.fade.rawValue)

        self.showUserPositionOnMap.setBackgroundImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.showUserPositionOnMap.layer.add(animation, forKey: CATransitionType.fade.rawValue)
            self.showUserPositionOnMap.setBackgroundImage(UIImage(systemName: "location.circle"), for: .normal)
        }
        self.map.zoomToUserLocation()
    }
    
    
    // MARK: - MANAGING PERMISSIONS
    private func askUserForGaleryPermission(completion: @escaping () -> Void){
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            completion()
            break
        case .notDetermined:
            let photos = PHPhotoLibrary.authorizationStatus()
            if photos == .notDetermined {
                PHPhotoLibrary.requestAuthorization({status in
                    if(status == .authorized){
                        completion()
                    }
                })
            }
            break
        case .restricted:
            break
        case .denied:
           self.managePermissionDenied()
           break
        @unknown default:
            break
        }
    }
    
    private func managePermissionDenied(){
        let alert = UIAlertController(title: "Camera", message: "Nous avons besoin d'accéder à la galerie pour effectuer cette action", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Activer", style: .default, handler: { action in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }))
        alert.addAction(UIAlertAction(title: "Annuler", style: .default, handler: nil))
        // Show the alert with animation
        self.present(alert, animated: true)
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
    
    private func setSegmentedController(){
        let statusBarY = Int((self.view.window?.windowScene?.statusBarManager?.statusBarFrame.height)! + 20)
        let segmentedControllerWidth = Int(self.view.frame.width - 250)
        
        let items = ["All", "< 5 km"]
        segmentedController = UISegmentedControl(items: items)
        segmentedController.addTarget(self, action: #selector(switchView), for: .valueChanged)
        segmentedController.selectedSegmentIndex = 0
        segmentedController.frame = CGRect(x: 0, y: 0,
                                width: segmentedControllerWidth, height: 40)
        segmentedController.center = CGPoint(x: self.view.frame.width/2, y: CGFloat(statusBarY))
        segmentedController.layer.masksToBounds = true
        segmentedController.layer.cornerRadius = 50.0
        segmentedController.backgroundColor = #colorLiteral(red: 0.3329149187, green: 0.7918291092, blue: 0.4867307544, alpha: 1)
        segmentedController.tintColor = UIColor.secondarySystemBackground
        self.view.addSubview(segmentedController)
    }
    
    
    // MARK: - MANAGING BOTTOM SHEET
    
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
    
    @objc func openAddPlace() {
        askUserForGaleryPermission {
            DispatchQueue.main.async {
               self.closeBottomSheet()
               self.navigationController?.pushViewController(AddPlaceViewController(), animated: true)
           }
        }
    }
    
    @objc func openListReservation() {
        if(userID != nil) {
            DisponibilityAPIService.default.getByIdUser(idUser: userID!) { (dispo) in
                let lvc = ListReservationViewController()
                let currentDispo = dispo.filter({ (dis) -> Bool in
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "ddMMyyyy"
                    let date = dateFormatter.date(from: dis.date)!
                    let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: date)!
                    if(nextDate >= Date()) {
                        return true
                    }
                    return false
                })
                lvc.listDispo = currentDispo.sorted(by: { (a, b) -> Bool in
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "ddMMyyyy"
                    let dateA = dateFormatter.date(from: a.date)!
                    let dateB = dateFormatter.date(from: b.date)!
                    return dateB > dateA
                })
                DispatchQueue.main.async {
                    self.closeBottomSheet()
                    self.navigationController?.pushViewController(lvc, animated: true)
                }
            }
        } else {
            let alert = UIAlertController(title: "Avertissement", message: "Désolé", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                self.navigationController?.pushViewController(LoginScreenViewController(), animated: true)
            }))
            self.present(alert, animated: true)
        }
    }

    @objc func bookPlace(){
        let placeId = self.places[indexForBook].id
        present(ReservationViewController.instance.alert(idPlace : placeId), animated: true)
    }
    
    @objc func sharePlaceAdress(sender: UIView){
        askUserForGaleryPermission{
            DispatchQueue.main.async {
                if(self.bottomSheetExtanded){
                    self.hideBottomSheet(delta: 2 * Int(self.view.frame.height/3))
                    self.bottomSheetExtanded = false
                }
                self.hideBottomSheet(delta: Int(self.view.frame.height/3))
                UIGraphicsBeginImageContext(self.view.frame.size)
                self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
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
        }
    }
    
    
    // MARK: - SETUP SECTION
    
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
    
    func hideNavigationBar(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func showNavigationBar(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
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
    
    private func setMainButton() {
        self.fanMenu.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        self.fanMenu.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height - 75)
        self.fanMenu.backgroundColor = .clear
        self.fanMenu.button = FanMenuButton(
            id: "main",
            image: UIImage(named: "ellipsis"),
            color: .rgb(r: 84, g: 200, b: 123)
        )
        self.fanMenu.items = [
            FanMenuButton(
                id: "logout",
                image: UIImage(named: "logout"),
                color: .white
            ),
            FanMenuButton(
                id: "reservations",
                image: UIImage(named: "reservation"),
                color: .white
            ),
            FanMenuButton(
                id: "addPlace",
                image: UIImage(named: "addPlace"),
                color: .white
            ),
            FanMenuButton(
                id: "categories",
                image: UIImage(named: "activities"),
                color: .white
            )
        ]

        fanMenu.menuRadius = 75.0
        fanMenu.duration = 0.2
        fanMenu.interval = (0, -171*Double.pi/128)
        fanMenu.radius = 25.0
        fanMenu.delay = 0.0

        fanMenu.onItemWillClick = { button in
            switch (button.id) {
                case "main" :
                    break
                case "categories" :
                    self.navigationController?.popViewController(animated: true)
                    break
                case "addPlace" :
                    self.openAddPlace()
                    break
                case "reservations" :
                    self.openListReservation()
                    break
                case "logout" :
                    self.navigationController?.pushViewController(LoginScreenViewController(), animated: true)
                    break
                default :
                    break
            }
        }

        fanMenu.backgroundColor = .clear
        self.view.addSubview(self.fanMenu)
    }

}

    // MARK: - EXTENSIONS

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

    private func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
           print("error::: \(error)")
           locationManager.stopUpdatingLocation()
           let alert = UIAlertController(title: "Settings", message: "Allow location from settings", preferredStyle: UIAlertController.Style.alert)
           self.present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "TEST", style: .default, handler: { action in
               switch action.style{
               case .default: UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
               case .cancel: print("cancel")
               case .destructive: print("destructive")
               @unknown default:
                break
            }
           }))
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
