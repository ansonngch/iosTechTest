//
//  VideoPreviewViewController.swift
//  iOS Technical Test
//
//  Created by Casey Law on 11/12/18.
//  Copyright © 2018 Lomotif. All rights reserved.
//

import UIKit

class VideoPreviewViewController: UIViewController {
    @IBOutlet weak var videoPlayerView: VideoPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let path = Bundle.main.path(forResource: "Movie", ofType:"mp4") else {
            debugPrint("Movie.mp4 not found")
            return
        }
        videoPlayerView.configure(url: path)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
