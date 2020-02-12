//
//  ReservationViewController.swift
//  Findout
//
//  Created by Vithursan Sivakumaran on 09/01/2020.
//  Copyright © 2020 Ramzy Kermad. All rights reserved.
//

import UIKit
import Alamofire

class ReservationViewController: UIViewController {

    // MARK: - VARIABLES
    @IBOutlet weak var reservationView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var placeTextField: UITextField!
    @IBOutlet weak var creneauLabel: UILabel!
    @IBOutlet weak var creneauTextField: UITextField!
    @IBOutlet weak var dureeCreneauTextField: UITextField!
    @IBOutlet weak var valideButtonLabel: UIButton!
    @IBOutlet weak var cancelButtonLabel: UIButton!

    static let instance = ReservationViewController()

    var disponibilityServices: DisponibilityServices{
        return DisponibilityAPIService()
    }

    var numDate = ["", "00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"]

    var datePicker = UIDatePicker()
    var creneauPicker = UIPickerView()
    var dureePicker = UIPickerView()
    var placePicker = UIPickerView()
    var arrCategory : [CategoryDao] = []
    var arrDispo : [DisponibilityDao] = [] {
        didSet{
            creneauPicker.reloadAllComponents()
        }
    }
    var place : PlaceDao! {
        didSet{
            creneauPicker.reloadAllComponents()
            creneauTextField.isEnabled = true
        }
    }
    var debutCreneau : Double! {
        didSet{
            dureePicker.reloadAllComponents()
        }
    }

    var nbPlace : Int! {
        didSet{
            placePicker.reloadAllComponents()
        }
    }

    var userId : String? = UserDefaults.standard.string(forKey: "userID")
    var placeId : String = ""

    
    // MARK: - OVERRIDE FUNC
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupDatePicker()
        setupCreneauPicker()
        setupDureePicker()
        setupPlacePicker()
    }

    // MARK: - SETUPS
    func setupView() {
        dateLabel.text = NSLocalizedString("reservation.date", comment: "")
        creneauLabel.text = NSLocalizedString("reservation.creneau", comment: "")
        placeLabel.text = NSLocalizedString("reservation.place", comment: "")
        valideButtonLabel.setTitle(NSLocalizedString("reservation.valider", comment: ""), for: .normal)
        cancelButtonLabel.setTitle(NSLocalizedString("reservation.cancel", comment: ""), for: .normal)
        dateTextField.delegate = self
        creneauTextField.placeholder = NSLocalizedString("reservation.heure", comment: "")
        creneauTextField.delegate = self
        dureeCreneauTextField.placeholder = NSLocalizedString("reservation.duree", comment: "")
        dureeCreneauTextField.delegate = self
        reservationView.layer.cornerRadius = 15
        creneauTextField.isEnabled = false
        dureeCreneauTextField.isEnabled = false
        placeTextField.isEnabled = false
        placeTextField.delegate = self
    }

    func setupDatePicker() {
        datePicker.minimumDate = Date()
        dateTextField.inputView = datePicker
        dateTextField.inputAccessoryView = setupPickerToolbar(select: #selector(doneDatePicker))
        datePicker.datePickerMode = UIDatePicker.Mode.date
    }

    func setupCreneauPicker() {

        creneauPicker.tag = 1
        creneauTextField.inputView = creneauPicker
        creneauPicker.delegate = self
        creneauTextField.inputAccessoryView = setupPickerToolbar(select: #selector(doneCreneauPicker))
    }

    func setupDureePicker() {
        dureePicker.tag = 2
        dureeCreneauTextField.inputView = dureePicker
        dureePicker.delegate = self
        dureeCreneauTextField.inputAccessoryView = setupPickerToolbar(select: #selector(doneDureePicker))
    }

    func setupPlacePicker() {
        placePicker.tag = 3
        placeTextField.inputView = placePicker
        placePicker.delegate = self
        placeTextField.inputAccessoryView = setupPickerToolbar(select: #selector(donePlacePicker))
    }
    
    func setupPickerToolbar(select : Selector) -> UIToolbar{
        let toolbar = UIToolbar();
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(title: NSLocalizedString("done", comment: ""), style: .plain, target: self, action: select)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: NSLocalizedString("cancel", comment: ""), style: .plain, target: self, action: #selector(cancelPicker))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)

        return toolbar
    }

    // MARK: - ACTIONS
    
    @IBAction func valideButton(_ sender: UIButton) {
        if(checkField()){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "ddMMyyyy"
            let selectedDate = dateFormatter.string(from: datePicker.date)
            guard let debut = Double(creneauTextField.text!),
                let duree = Double(dureeCreneauTextField.text!) else {
                    return
            }
            let fin = debut + duree
            if(userId != nil) {
                DisponibilityAPIService.default.addDisponibility(id_place: placeId, id_user: userId!, startTime: creneauTextField.text!, endTime: String(String(fin).prefix(2)), date: selectedDate, nbPlace: placeTextField.text!) { (status) in
                    if(status == 200) {
                        let alert = UIAlertController(title: NSLocalizedString("place.alertTitleSuccess", comment: ""), message: NSLocalizedString("place.alertSuccessReservation", comment: ""), preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self.dismiss(animated: true)
                            }
                        })
                        self.present(alert, animated: true)
                    } else {
                    let alert = UIAlertController(title: NSLocalizedString("place.alertTitleFailure", comment: ""),                                     message: NSLocalizedString("place.alertMissingFields", comment: ""),
                                                  preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self.dismiss(animated: true)
                            }
                        })
                        self.present(alert, animated: true)
                    }
                }
            } else {
                let alert = UIAlertController(title: NSLocalizedString("alert.warning.title", comment: ""), message: NSLocalizedString("alert.warning.message", comment: ""), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    self.navigationController?.pushViewController(LoginScreenViewController(), animated: true)
                }))
                self.present(alert, animated: true)
            }
        } else {
            let alert = UIAlertController(title: NSLocalizedString("place.alertTitleFailure", comment: ""),
                                          message: NSLocalizedString("place.alertMissingFields", comment: ""), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }

    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true)
    }

    @objc
    func doneDatePicker() {
    //For date formate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let selectedDate = dateFormatter.string(from: datePicker.date)
        dateTextField.text = selectedDate
        dateFormatter.dateFormat = "ddMMyyyy"
        let formattedDate = dateFormatter.string(from: datePicker.date)
        DisponibilityAPIService.default.getByIdPlaceAndDate(placeId: placeId, date: formattedDate) { (res) in
            self.arrDispo = res
        }
        PlaceAPIService.default.getById(id: placeId) { (res) in
            self.place = res
        }
        dureeCreneauTextField.isEnabled = false
        placeTextField.isEnabled = false
        //dismiss date picker dialog
        self.view.endEditing(true)
    }

    @objc func cancelPicker(){
        //cancel button dismiss datepicker dialog
        self.view.endEditing(true)
    }

    @objc func doneCreneauPicker(){
        //cancel button dismiss datepicker dialog
        if(Double(creneauTextField.text!) != nil) {
            debutCreneau = Double(creneauTextField.text!)
            dureeCreneauTextField.isEnabled = true
        }
        self.view.endEditing(true)
    }

    @objc func doneDureePicker(){
        //cancel button dismiss datepicker dialog
        if(Double(dureeCreneauTextField.text!) != nil && Double(creneauTextField.text!) != nil) {
            var nbPlaceAvailable = 0
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "ddMMyyyy"
            let formattedDate = dateFormatter.string(from: datePicker.date)
            arrDispo.forEach { (dispo) in
                if(dispo.date == formattedDate){
                    guard let debutDispo = Double(dispo.startTime.prefix(2)),
                        let finDispo = Double(dispo.endTime.prefix(2)),
                        let debut = Double(creneauTextField.text!),
                        let duree = Double(dureeCreneauTextField.text!) else {
                        return
                    }
                    let fin = debut + duree
                    if(((debutDispo <= debut) && (finDispo >= fin)) || ((debutDispo >= debut) && (finDispo <= fin))){
                        nbPlaceAvailable += dispo.placesAvailable
                    }
                }
            }
            nbPlace = place.availableSeat - nbPlaceAvailable
            placeTextField.isEnabled = true
        }
        self.view.endEditing(true)
    }

    @objc func donePlacePicker() {
        //cancel button dismiss datepicker dialog
        self.view.endEditing(true)
    }

    // MARK: - UTILS
    
    func checkField() -> Bool {
        if(dateTextField.text != "" && creneauTextField.text != "" && dureeCreneauTextField.text != "" && placeTextField.text != "") {
            return true
        } else {
            return false
        }
    }

    func alert(idPlace : String) -> ReservationViewController {
        let story = UIStoryboard(name: "ReservationViewController", bundle: .main)
        let alert = story.instantiateViewController(identifier: "ReservationVC") as! ReservationViewController
        alert.placeId = idPlace
        return alert
    }
}

    // MARK: - EXTENSIONS
extension ReservationViewController: UIPickerViewDelegate {

}

extension ReservationViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 1 ) {
            return setCreneauPickerViewAfterChooseDate().count
        } else if (pickerView.tag == 2) {
            return setDureePickerViewAfterChooseDate().count
        } else if (pickerView.tag == 3) {
            return setPlacePickerViewAfterChooseDuree().count
        }
          return 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 1) {
           return setCreneauPickerViewAfterChooseDate()[row]
      } else if (pickerView.tag == 2) {
            return setDureePickerViewAfterChooseDate()[row]
        } else if (pickerView.tag == 3) {

            return setPlacePickerViewAfterChooseDuree()[row]
        }
        return ""
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView.tag == 1) {
            creneauTextField.text = setCreneauPickerViewAfterChooseDate()[row]
        } else if (pickerView.tag == 2) {
            dureeCreneauTextField.text = setDureePickerViewAfterChooseDate()[row]
        } else if (pickerView.tag == 3) {
            placeTextField.text = setPlacePickerViewAfterChooseDuree()[row]
        }
    }

    func setCreneauPickerViewAfterChooseDate() -> [String] {
        var tab : [String] = [""]
        if(place != nil){
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "HH"
            guard let debutToday = Double(dateFormat.string(from: Date())),
                let dispoStart = place.disponibilityStartTime,
                let debutOther = Double(dispoStart.prefix(2)),
                let dispoEnd = place.disponibilityEndTime,
                var fin = Double(dispoEnd.prefix(2)) else {
                    return ["nil"]
            }
            var debut : Double = debutOther
            dateFormat.dateFormat = "dd MMMM yyyy"
            let dateChoosen = dateFormat.date(from: dateTextField.text!)!
            let date1 = Calendar.current.component(.day, from: Date())
            let date2 = Calendar.current.component(.day, from: dateChoosen)
            if(date1 == date2) {
                debut = debutToday
                debut += 1
            }
            fin -= 1
            var i = 1
            while(Double(numDate[i])!.isLessThanOrEqualTo(fin)){
                if(debut.isLessThanOrEqualTo(Double(numDate[i])!)){
                    tab.append(numDate[i])
                }

                i+=1
            }
        } else {
            tab = numDate
        }
        dureeCreneauTextField.text = ""
        dureeCreneauTextField.isEnabled = false
        placeTextField.text = ""
        placeTextField.isEnabled = false
        creneauTextField.text = ""
        return tab
    }

    func setDureePickerViewAfterChooseDate() -> [String] {
        var tab : [String] = [""]
        guard let dispoEnd = place.disponibilityEndTime,
            let fin = Double(dispoEnd.prefix(2)),
            var debut = debutCreneau else {
                return [""]
        }
        var i = 1
        while (debut < fin) {
            tab.append(String(i))
            i += 1
            debut += 1
        }
        placeTextField.text = ""
        placeTextField.isEnabled = false
        dureeCreneauTextField.text = ""
        return tab
    }

    func setPlacePickerViewAfterChooseDuree() -> [String] {
        var tab : [String] = [""]
        guard let nbSeat = nbPlace else {
            return [""]
        }
        var i = 1
        while(i <= nbSeat) {
            tab.append(String(i))
            i += 1
        }
        return tab
    }
}

extension ReservationViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}
