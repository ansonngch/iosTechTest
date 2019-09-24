//
//  PictureFeedCollectionViewController.swift
//  iOS Technical Test
//
//  Created by Casey Law on 11/12/18.
//  Copyright © 2018 Lomotif. All rights reserved.
//

import UIKit

class PictureFeedCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let viewModel = PictureFeedViewModel()
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onLoadingChange = {[weak self] (isLoading) in
            isLoading ? self?.indicator.startAnimating() : self?.indicator.stopAnimating()
        }
        
        viewModel.dataLoaded = {[weak self] in
            self?.collectionView.reloadData()
        }
        
        setupLoader()
        viewModel.loadData(isReload: false)
    }
    
    func setupLoader() {
        indicator.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        indicator.center = view.center
        indicator.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        self.view.addSubview(indicator)
        self.view.bringSubviewToFront(indicator)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return viewModel.getTotalCount()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: PictureFeedCollectionViewCell.className, for: indexPath) as? PictureFeedCollectionViewCell)!

        let data = viewModel.getDataFor(item: indexPath.row)
        cell.updateView(data: data)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 6)
        let cellWidth = width / 3
        let height = cellWidth
        
        return CGSize(width: cellWidth, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.getTotalCount() - 1 {
            viewModel.loadData(isReload: true)
        }
    }
}
