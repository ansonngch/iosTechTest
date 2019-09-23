//
//  PictureFeedCollectionViewCell.swift
//  iOSTechnicalTest
//
//  Created by Anson on 23/9/19.
//  Copyright © 2019 Lomotif. All rights reserved.
//

import UIKit

class PictureFeedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgPicture: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    private func setupView() {
        self.layer.cornerRadius = 8
        self.backgroundColor = .red
    }
}
