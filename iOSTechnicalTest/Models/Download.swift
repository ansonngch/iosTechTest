//
//  Download.swift
//  iOSTechnicalTest
//
//  Created by Anson on 28/9/19.
//  Copyright © 2019 Lomotif. All rights reserved.
//

import Foundation

class Download {
    var isDownloading = false
    var progress: Float = 0
    var resumeData: Data?
    var task: URLSessionDownloadTask?
    var track: URLFile?
    
    init(track: URLFile) {
        self.track = track
    }
}
