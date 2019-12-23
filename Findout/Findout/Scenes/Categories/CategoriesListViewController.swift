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
    
    var categories: [CategoryDao] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        categoryGrid.delegate = self
        categoryGrid.dataSource = self
        self.categoryGrid.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil),
        forCellWithReuseIdentifier: "ER_TYPE_CELL")
    }
}

extension CategoriesListViewController: UICollectionViewDelegate{
    
}

extension CategoriesListViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //self.categories.count
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ER_TYPE_CELL", for: indexPath) as! CategoryCollectionViewCell
        
        
        return cell
    }
    
    
}
