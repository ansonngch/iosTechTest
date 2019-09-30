//
//  URLFile.swift
//  iOSTechnicalTest
//
//  Created by Anson on 28/9/19.
//  Copyright © 2019 Lomotif. All rights reserved.
//

import Foundation

class URLFile {
    //
    // MARK: - Constants
    //
    let previewURL: URL
    
    //
    // MARK: - Variables And Properties
    //
    var downloaded = false
    
    //
    // MARK: - Initialization
    //
    init(previewURL: URL) {
        self.previewURL = previewURL
    }
}
