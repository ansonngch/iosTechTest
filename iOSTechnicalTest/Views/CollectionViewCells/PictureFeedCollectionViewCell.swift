//
//  PictureFeedCollectionViewCell.swift
//  iOSTechnicalTest
//
//  Created by Anson on 23/9/19.
//  Copyright © 2019 Lomotif. All rights reserved.
//

import UIKit
import Kingfisher

class PictureFeedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgPicture: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    private func setupView() {
        self.layer.cornerRadius = 8
        self.imgPicture.contentMode = .scaleAspectFill
        self.imgPicture.clipsToBounds = true
    }
    
    func updateView(data: Hits) {
        if let url = URL(string: data.previewURL ?? "") {
            self.imgPicture.kf.setImage(with: url)
        }
    }
}
