//
//  AddPlaceViewController.swift
//  Findout
//
//  Created by Vithursan Sivakumaran on 29/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation
import GooglePlaces

class AddPlaceViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeNameTextField: UITextField!
    //@IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var seatLabel: UILabel!
    @IBOutlet weak var seatTextField: UITextField!
    @IBOutlet weak var dispoLabel: UILabel!
    @IBOutlet weak var dispoStartTextField: UITextField!
    @IBOutlet weak var dispoEndTextField: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryTextField: UITextField!
    
    let categoryPicker = UIPickerView()
    let seatPicker = UIPickerView()
    let numTab = Array(1...100)
    var numTabString : [String] = [""]
    
    let dateStartPicker = UIPickerView()
    let dateEndPicker = UIPickerView()
    let numDate = [["", "00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"], ["", "05", "10", "15", "20", "25", "30", "35", "40", "45", "50", "55"]]
    
    var categoryList : [CategoryDao] = [CategoryDao.init(name: "", imageUrl: "", idCat: "", idActivity: "")]{
        didSet{
            categoryPicker.reloadAllComponents()
        }
    }
    var categoryId : String = ""
    
    var placeServices: PlaceServices{
        return PlaceAPIService()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCategoryPicker()
        setupSeatPicker()
        setupDispoPicker()
        setupImageClick()
        //styleDescription()
        hideKeyboard()
        
        numTabString += numTab.map{ String($0)}
        
        CategoryAPIService.default.getAll { (res) in
            self.categoryList += res
        }
        
        categoryTextField.delegate = self
        seatTextField.delegate = self
    }
    
    @IBAction func addressTextFieldTapped(_ sender: Any) {
        addressTextField.resignFirstResponder()
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        present(acController, animated: true, completion: nil)
    }
    
    @IBAction func uploadPlace(_ sender: UIButton) {
        
        guard let address = addressTextField.text,
            let name = placeNameTextField.text,
            let seat = seatTextField.text,
            let dispoStart = dispoStartTextField.text,
            let dispoEnd = dispoEndTextField.text,
            address.count > 0,
            seat.count > 0,
            name.count > 0,
            dispoStart.count > 4,
            dispoEnd.count > 4 else {
                self.warningAlert(title: NSLocalizedString("place.alertTitleFailure", comment: ""),
                                  message: NSLocalizedString("place.alertMissingFields", comment: ""))
                return
        }
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, err) in
            guard err == nil,
                let allPlacemarks = placemarks,
                let place = allPlacemarks.first,
                let loc = place.location,
                let country = place.country,
                let postalCode = place.postalCode,
                let address = place.name,
                let city = place.locality else {
                    self.warningAlert(title: NSLocalizedString("place.alertTitleFailure", comment: ""),
                                      message: NSLocalizedString("place.alertAdressNotFound", comment: ""))
                    return
            }
            let coord : [String:String] = [
                "lon" : String(loc.coordinate.longitude),
                "lat" : String(loc.coordinate.latitude)
            ]
            let params : [String : Any] = [
                "name" : self.placeNameTextField.text!,
                "coordinate" : coord,
                "nb_seat" : self.seatTextField.text!,
                "nb_seat_free" : self.seatTextField.text!,
                "address" : "\(address), \(postalCode) \(city), \(country)",
                "idCategory" : self.categoryId,
                "disponibilityStartTime" : self.dispoStartTextField.text!,
                "disponibilityEndTime" : self.dispoEndTextField.text!
            ]
            self.placeServices.create(params: params, image: self.imageView.image!) { (res) in
                self.warningAlert(title: NSLocalizedString("place.alertTitleSuccess", comment: ""),
                                  message: NSLocalizedString("place.alertSuccessMessage", comment: ""))
                self.navigationController?.pushViewController(PlacesScreenViewController(), animated: true)
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func openGallery() {
        let image = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            image.delegate = self
            image.sourceType = .photoLibrary
            image.allowsEditing = false
            self.present(image, animated: true, completion: nil)
        } else {
            warningAlert(title: NSLocalizedString("place.alertTitleFailure", comment: ""),
                         message: NSLocalizedString("place.alertNoGalleryPermission", comment: ""))
        }
    }
    
    func openCamera() {
        let image = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            image.delegate = self
            image.sourceType = .camera
            image.allowsEditing = false
            self.present(image, animated: true, completion: nil)
        } else {
            warningAlert(title: NSLocalizedString("place.alertTitleFailure", comment: ""),
                         message: NSLocalizedString("palce.alertNoCameraPermission", comment: ""))
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image =  info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
        } else {
            print("fail image")
        }
        hideKeyboard()
        self.dismiss(animated: true, completion: nil)
    }
    
    func hideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func warningAlert(title: String, message : String) {
        let alertWarn = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: .alert)
        
        alertWarn.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertWarn, animated: true, completion: nil)
    }
    
    func setupView() {
        self.placeNameLabel.text = NSLocalizedString("place.name", comment: "")
        self.addressLabel.text = NSLocalizedString("place.address", comment: "")
        self.dispoLabel.text = NSLocalizedString("place.dispo", comment: "")
        self.seatLabel.text = NSLocalizedString("place.seat", comment: "")
        self.sendBtn.setTitle(NSLocalizedString("place.send", comment: ""), for: .normal)
        self.dispoStartTextField.placeholder = NSLocalizedString("place.start", comment: "")
        self.dispoEndTextField.placeholder = NSLocalizedString("place.end", comment: "")
        self.categoryLabel.text = NSLocalizedString("place.category", comment: "")
    }
    
    func setupCategoryPicker() {
        categoryPicker.tag = 1
        categoryTextField.inputView = categoryPicker
        categoryPicker.delegate = self
    }
    
    func setupSeatPicker() {
        seatPicker.tag = 2
        seatTextField.inputView = seatPicker
        seatPicker.delegate = self
    }
    
    func setupDispoPicker() {
        dateStartPicker.tag = 3
        dispoStartTextField.inputView = dateStartPicker
        dateStartPicker.delegate = self
        dispoStartTextField.delegate = self
        
        dateEndPicker.tag = 4
        dispoEndTextField.inputView = dateEndPicker
        dateEndPicker.delegate = self
        dispoEndTextField.delegate = self
    }
    
    func setupImageClick() {
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(clickImage))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(singleTap)
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func clickImage() {
        let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let cancelActionButton = UIAlertAction(title: NSLocalizedString("place.cancel", comment: ""), style: .cancel) { _ in
            
        }
        actionSheetControllerIOS8.addAction(cancelActionButton)

        let cameraActionButton = UIAlertAction(title: NSLocalizedString("place.camera", comment: ""), style: .default)
            { _ in
                self.openCamera()
        }
        actionSheetControllerIOS8.addAction(cameraActionButton)

        let galleryActionButton = UIAlertAction(title: NSLocalizedString("place.gallery", comment: ""), style: .default)
            { _ in
                self.openGallery()
        }
        actionSheetControllerIOS8.addAction(galleryActionButton)
        self.present(actionSheetControllerIOS8, animated: true, completion: nil)
    }
}

extension AddPlaceViewController: UIPickerViewDelegate {
    
}

extension AddPlaceViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if(pickerView.tag == 1 || pickerView.tag == 2) {
            return 1
        } else if (pickerView.tag == 3 || pickerView.tag == 4) {
            return 2
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 1) {
            return categoryList.count
        } else if (pickerView.tag == 2) {
            return numTabString.count
        } else if (pickerView.tag == 3 || pickerView.tag == 4) {
            return numDate[component].count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 1) {
            return categoryList[row].name
        } else if (pickerView.tag == 2) {
            return numTabString[row]
        } else if (pickerView.tag == 3 || pickerView.tag == 4) {
            return numDate[component][row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView.tag == 1) {
            categoryTextField.text = categoryList[row].name
            categoryId = categoryList[row].idCategory
        } else if (pickerView.tag == 2) {
            seatTextField.text = numTabString[row]
        } else if (pickerView.tag == 3) {
            let hours =  numDate[0][pickerView.selectedRow(inComponent: 0)]
            let min = numDate[1][pickerView.selectedRow(inComponent: 1)]
            dispoStartTextField.text = hours + ":" + min
        } else if (pickerView.tag == 4) {
            let hours =  numDate[0][pickerView.selectedRow(inComponent: 0)]
            let min = numDate[1][pickerView.selectedRow(inComponent: 1)]
            dispoEndTextField.text = hours + ":" + min
        }
    }
}

extension AddPlaceViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}

extension AddPlaceViewController: UIActionSheetDelegate {
    
}

extension AddPlaceViewController: GMSAutocompleteViewControllerDelegate {
  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
    // Get the place name from 'GMSAutocompleteViewController'
    // Then display the name in textField
    addressTextField.text = place.formattedAddress
// Dismiss the GMSAutocompleteViewController when something is selected
    dismiss(animated: true, completion: nil)
  }
func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
    // Handle the error
    print("Error: ", error.localizedDescription)
  }
func wasCancelled(_ viewController: GMSAutocompleteViewController) {
    // Dismiss when the user canceled the action
    dismiss(animated: true, completion: nil)
  }
}
