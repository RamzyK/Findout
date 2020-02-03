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

    var activityList: [ActivityDao] = []{
        didSet{
            self.tableView.reloadData()
        }
    }

    var activityServices: ActivityServices{
        return ActivityAPIService()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupActivityCollectionView()
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
    
    func setupActivityCollectionView() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: CATEGORY_CELL)
        
        self.activityServices.getAll { (list) in
            self.activityList = list
        }
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let button = UIButton(type: .system)
        let sectionTitle = activityList[section].name
        button.setTitle(sectionTitle + " -", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleOpenCloseSections), for: .touchUpInside)
        button.tag = section
        
        return button
    }
    
    @objc func handleOpenCloseSections(button: UIButton) {

        let section = button.tag
        var indexPaths = [IndexPath]()

        for row in activityList[section].categories.indices {
            print(0, row)
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }

        let isExpanded = activityList[section].isExpanded
        activityList[section].isExpanded = !isExpanded
        let newTitle = button.titleLabel!.text! + (isExpanded ? " -" : " +")
        button.setTitle(newTitle, for: .normal)

        if isExpanded {
            tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return activityList.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !activityList[section].isExpanded {
            return 0
        }

        return activityList[section].categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CATEGORY_CELL, for: indexPath)
        let name = activityList[indexPath.section].categories[indexPath.row].name

        cell.textLabel?.text = name

        return cell
    }

}
