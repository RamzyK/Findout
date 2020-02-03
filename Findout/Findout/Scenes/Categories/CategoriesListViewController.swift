//
//  CategoriesListViewController.swift
//  Findout
//
//  Created by Ramzy Kermad on 23/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import UIKit

class CategoriesListViewController: UIViewController {
        
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    var activityLabel = ""
    var activityId : String = ""
    
    var categories: [CategoryDao] = [] {
        didSet {
            self.categoryCollectionView.reloadData()
        }
    }
    var categoriyServices: CategoryServices {
        return CategoryAPIService.default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        setupView()
        setupNavigationBar()
        setupCategoryCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    func setupView() {
        self.title = NSLocalizedString("categories.title", comment: "") + activityLabel
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2193810642, green: 0.7583789825, blue: 0.4023743272, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    func setupCategoryCollectionView() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        self.categoryCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil),
        forCellWithReuseIdentifier: "CATEGORY_CELL")

        categoriyServices.getById(activityId) { (cat) in
            self.categories = cat
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
        if(self.categories[indexPath.row].imageUrl != ""){
            cell.categoryImage.image = UIImage(named: "sport-category-icon")
        }else{
            cell.categoryImage.image = UIImage(named: "sport-category-icon")
        }
        cell.categoryName.text = self.categories[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let placeVC = PlacesScreenViewController()
        placeVC.categoryId = categories[indexPath.row].idCategory
        self.navigationController?.pushViewController(placeVC, animated: true)
    }
    
}
