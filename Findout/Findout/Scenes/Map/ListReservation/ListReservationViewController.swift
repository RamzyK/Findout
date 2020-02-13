//
//  ListReservationViewController.swift
//  Findout
//
//  Created by Vithursan Sivakumaran on 09/02/2020.
//  Copyright © 2020 Ramzy Kermad. All rights reserved.
//

import UIKit

class ListReservationViewController: UIViewController {

    var listDispo : [DisponibilityDao] = []
    @IBOutlet weak var middleLabel: UILabel!

    @IBOutlet weak var listReservationTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("listReservation.title", comment: "")
        if(listDispo.count == 0) {
            listReservationTableView.isHidden = true
            middleLabel.isHidden = false
        } else {
            listReservationTableView.isHidden = false
            middleLabel.isHidden = true
        }
        middleLabel.text = NSLocalizedString("listReservation.msgVide", comment: "")
        listReservationTableView.delegate = self
        listReservationTableView.dataSource = self
        listReservationTableView.register(UINib(nibName: "ListReservationCell", bundle: nil), forCellReuseIdentifier: ListReservationViewController.cellIdentifier)
        // Do any additional setup after loading the view.
    }


}

extension ListReservationViewController: UITableViewDelegate {

}

extension ListReservationViewController: UITableViewDataSource {
    public static let cellIdentifier = "LIST_RESERVATION_CELL_ID"
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listDispo.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMyyyy"
        let date = dateFormatter.date(from: listDispo[indexPath.row].date)
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let cell = tableView.dequeueReusableCell(withIdentifier: ListReservationViewController.cellIdentifier, for: indexPath) as! ListReservationCell
        PlaceAPIService.default.getById(id: listDispo[indexPath.row].placeID) { (place) in
            cell.title.text = place.name
        }
        cell.date.text = dateFormatter.string(from: date!)
        cell.debut.text = listDispo[indexPath.row].startTime
        cell.fin.text = listDispo[indexPath.row].endTime
        cell.nbPlace.text = "\(listDispo[indexPath.row].placesAvailable)"
        cell.theLabel.text = NSLocalizedString("listReservation.the", comment: "")
        cell.fromLabel.text = NSLocalizedString("listReservation.from", comment: "")
        cell.toLabel.text = NSLocalizedString("listReservation.to", comment: "")
        cell.nbPlaceLabel.text = NSLocalizedString("listReservation.places", comment: "")
        return cell
    }
}
