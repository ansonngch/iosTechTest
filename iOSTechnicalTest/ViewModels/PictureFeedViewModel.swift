//
//  PictureFeedViewModel.swift
//  iOSTechnicalTest
//
//  Created by Anson on 24/9/19.
//  Copyright © 2019 Lomotif. All rights reserved.
//

import Foundation

class PictureFeedViewModel {
    var currentPage = 1
    var pictureFeedData = [Hits]()
    
    var dataLoaded: (() -> Void)?
    var onLoadingChange: ((_ isLoading: Bool) -> Void)?
    
    var isLoading: Bool = false {
        didSet {
            onLoadingChange?(isLoading)
        }
    }
    
    func loadData(isReload: Bool) {
        if currentPage < 4 {
            let page = isReload ? currentPage + 1 : currentPage
            let parameters: [String: Any] = ["page": page]
            currentPage += 1
            isLoading = true
            APIManager.sharedInstance.sendJSONRequest(method: .get, path: APIManager.Router.getImage, parameters: parameters) { (apiResponse, error) in
                let result = apiResponse.hits
                if let response = result {
                    do {
                        let res = try JSONSerialization.data(withJSONObject: response, options: [])
                        let data = try JSONDecoder().decode([Hits].self, from: res)
                        self.pictureFeedData.append(contentsOf: data)
                    } catch {
                        
                    }
                }
                self.isLoading = false
                self.dataLoaded?()
            }
        }
    }
    
    func getTotalCount() -> Int {
        return self.pictureFeedData.count
    }
    
    func getDataFor(item: Int) -> Hits {
        return self.pictureFeedData[item]
    }
}
