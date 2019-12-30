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
    @IBOutlet weak var galleryBtn: UIButton!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var sendBtn: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        //styleDescription()
        hideKeyboard()
    }
    
    @IBAction func uploadPlace(_ sender: UIButton) {
        
        guard let address = addressTextField.text,
            let name = placeNameTextField.text,
            let seat = seatTextField.text,
            address.count > 0,
            seat.count > 0,
            name.count > 0 else {
                self.warningAlert(message: "Missing Required Field")
                return
        }
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, err) in
            guard err == nil,
                let allPlacemarks = placemarks,
                let place = allPlacemarks.first,
                let loc = place.location else {
                    self.warningAlert(message: "Address not found")
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
                "address" : self.addressTextField.text!,
                "disponibilityStartTime" : self.dispoStartTextField.text!,
                "disponibilityEndTime" : self.dispoEndTextField.text!
            ]
            PlaceAPIService.default.create(params: params, image: self.imageView.image!) { (res) in
                self.warningAlert(message: "Votre place a bien été ajouté")
                self.navigationController?.pushViewController(PlacesScreenViewController(), animated: true)
            }
        }
    }
    
    @IBAction func openCameraBtn(_ sender: UIButton) {
        let image = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            image.delegate = self
            image.sourceType = .camera
            image.allowsEditing = false
            self.present(image, animated: true, completion: nil)
        } else {
            warningAlert(message: "You don't have camera")
        }
    }
    
    @IBAction func openGalleryBtn(_ sender: UIButton) {
        let image = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            image.delegate = self
            image.sourceType = .photoLibrary
            image.allowsEditing = false
            self.present(image, animated: true, completion: nil)
        } else {
            warningAlert(message: "You don't have gallery")
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
    /*
    func styleDescription() {
        descriptionTextField!.layer.borderWidth = 4
        descriptionTextField!.layer.cornerRadius = 6
        descriptionTextField!.layer.borderColor = UIColor.green.cgColor
    }
    */
    func hideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func warningAlert(message : String) {
        let alertWarn = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        alertWarn.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertWarn, animated: true, completion: nil)
    }
    
    func setupView() {
        self.placeNameLabel.text = NSLocalizedString("place.name", comment: "")
        self.addressLabel.text = NSLocalizedString("place.address", comment: "")
        self.dispoLabel.text = NSLocalizedString("place.dispo", comment: "")
        self.seatLabel.text = NSLocalizedString("place.seat", comment: "")
        self.sendBtn.setTitle(NSLocalizedString("place.send", comment: ""), for: .normal)
        self.galleryBtn.setTitle(NSLocalizedString("place.gallery", comment: ""), for: .normal)
        self.cameraBtn.setTitle(NSLocalizedString("place.camera", comment: ""), for: .normal)
        self.dispoStartTextField.placeholder = NSLocalizedString("place.start", comment: "")
        self.dispoEndTextField.placeholder = NSLocalizedString("place.end", comment: "")
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
