//
//  CategoryCell.swift
//  Findout
//
//  Created by Nassim Morouche on 03/02/2020.
//  Copyright © 2020 Ramzy Kermad. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    var categoryImage = UIImageView()
    var categoryLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(categoryImage)
        contentView.addSubview(categoryLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
