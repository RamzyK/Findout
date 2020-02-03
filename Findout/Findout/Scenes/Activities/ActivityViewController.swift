//
//  ActivityViewController.swift
//  Findout
//
//  Created by Ramzy Kermad on 24/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import UIKit

class ActivityViewController: UITableViewController {
    
    let CATEGORY_CELL = "CATEGORY_CELL"
        
    var activityList: [ActivityDao] = []
    
    var activityServices: ActivityServices{
        return ActivityAPIService()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        setupView()
        setupActivityTableView()
    }
    
    func setupView() {
        self.title = NSLocalizedString("activities.title", comment: "")
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        self.navigationItem.setHidesBackButton(true, animated:true);
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2193810642, green: 0.7583789825, blue: 0.4023743272, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    func setupActivityTableView() {
        self.tableView.register(CategoryCell.self, forCellReuseIdentifier: CATEGORY_CELL)
        tableView.separatorStyle = .none
        
        self.activityServices.getAll { (list) in
            self.activityList = list
            self.tableView.reloadData()
        }
    }
    
    @objc func handleOpenCloseSections(button: UIButton) {
        
        var indexPaths = [IndexPath]()
        let label = button.subviews[1] as? UILabel
        let section = button.tag
        
        for row in activityList[section].categories.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        let isExpanded = activityList[section].isExpanded
        activityList[section].isExpanded = !isExpanded
        
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = 0.3
        
        label?.layer.add(animation, forKey: CATransitionType.fade.rawValue)
        label?.text = !isExpanded ? "-" : "+"

        button.layer.add(animation, forKey: CATransitionType.fade.rawValue)
        button.backgroundColor = !isExpanded ? #colorLiteral(red: 0.5723067522, green: 0.5723067522, blue: 0.5723067522, alpha: 1) : #colorLiteral(red: 0.3764309287, green: 0.3764309287, blue: 0.3764309287, alpha: 1)
        
        if isExpanded {
            tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return activityList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return !activityList[section].isExpanded ? 0 : activityList[section].categories.count
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton(type: .system)
        let label = UILabel()
        let sectionTitle = activityList[section].name.capitalized
        
        button.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50)
        button.backgroundColor = #colorLiteral(red: 0.3764309287, green: 0.3764309287, blue: 0.3764309287, alpha: 1)
        button.setTitle(sectionTitle, for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.init(name: UIFont.familyNames[0], size: 30)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleOpenCloseSections), for: .touchUpInside)
        button.tag = section
        
        label.frame = CGRect(x: tableView.frame.width - 20, y: 0, width: 20, height: 50)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.text = "+"
        
        button.addSubview(label)
        
        return button
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CATEGORY_CELL, for: indexPath) as! CategoryCell
        let name = activityList[indexPath.section].categories[indexPath.row].name.capitalized
        
        tableView.rowHeight = 70
        cell.categoryImage.frame = CGRect(x: 20, y: 10, width: 50, height: 50)
        cell.categoryLabel.frame = CGRect(x: cell.categoryImage.frame.width + 100, y: 0, width: tableView.frame.width - (cell.categoryImage.frame.width + 100), height: 70)
        
        let imageUrl = URL(string: self.activityList[indexPath.section].categories[indexPath.row].imageUrl)
        if let imageData = try? Data(contentsOf: imageUrl!) {
            cell.categoryImage.image = UIImage(data: imageData)
        } else {
            cell.categoryImage.image = UIImage(named: "image-not-found")
        }
        
        cell.categoryLabel.text = name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let placeVC = PlacesScreenViewController()
        placeVC.categoryId = self.activityList[indexPath.section].categories[indexPath.row].idCategory
        self.navigationController?.pushViewController(placeVC, animated: true)
    }
}
