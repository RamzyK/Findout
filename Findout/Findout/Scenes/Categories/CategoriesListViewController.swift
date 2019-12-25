//
//  CategoriesListViewController.swift
//  Findout
//
//  Created by Ramzy Kermad on 23/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import UIKit

class CategoriesListViewController: UIViewController {
        
    @IBOutlet weak var categoryGrid: UICollectionView!
    var activityLabel = ""
    
    var categories: [CategoryDao] = [] {
        didSet {
            self.categoryGrid.reloadData()
        }
    }
    var categoriyServices: CategoryServices {
        return CategoryMockServices()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2193810642, green: 0.7583789825, blue: 0.4023743272, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

        self.title = NSLocalizedString("categories.title", comment: "") + activityLabel
        categoryGrid.delegate = self
        categoryGrid.dataSource = self
        self.categoryGrid.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil),
        forCellWithReuseIdentifier: "CATEGORY_CELL")
        self.categoriyServices.getAll { (categoryList) in
            self.categories = categoryList
        }
    }
}

extension CategoriesListViewController: UICollectionViewDelegate{
    
}

extension CategoriesListViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //self.categories.count
        return self.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CATEGORY_CELL", for: indexPath) as! CategoryCollectionViewCell
        cell.categoryImage.image = UIImage(named: "sport-category-icon")
        cell.categoryName.text = self.categories[indexPath.row].name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
