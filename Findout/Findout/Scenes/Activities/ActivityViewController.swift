//
//  ActivityViewController.swift
//  Findout
//
//  Created by Ramzy Kermad on 24/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {
    
    @IBOutlet weak var activitiesCollectionView: UICollectionView!
    
    var activityList: [ActivityDao] = []{
        didSet{
            self.activitiesCollectionView.reloadData()
        }
    }
    var activityServices: ActivityServices{
        return ActivityMockServices()
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
        self.activitiesCollectionView.delegate = self
        self.activitiesCollectionView.dataSource = self
        self.activitiesCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil),
        forCellWithReuseIdentifier: "CATEGORY_CELL")
        
//        self.activityServices.getAll { (list) in
//            self.activityList = list
//        }
        ActivityAPIService.default.getAll { (res) in
            self.activityList = res
        }
        
    }
}


extension ActivityViewController: UICollectionViewDelegate{
    
}

extension ActivityViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.activityList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CATEGORY_CELL", for: indexPath) as! CategoryCollectionViewCell
        cell.categoryName.text = activityList[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let categoriesVC = CategoriesListViewController()
        categoriesVC.activityLabel = activityList[indexPath.row].name
        categoriesVC.activityId = activityList[indexPath.row].id
        self.navigationController?.pushViewController(categoriesVC, animated: true)
    }
    
}
