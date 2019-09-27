//
//  VideoPreviewViewController.swift
//  iOS Technical Test
//
//  Created by Casey Law on 11/12/18.
//  Copyright © 2018 Lomotif. All rights reserved.
//

import UIKit

protocol DownloadDelegate: class {
    func downloadProgressUpdate(for progress: Float)
}

class VideoPreviewViewController: UIViewController {
    @IBOutlet weak var videoPlayerView: VideoPlayerView!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var lblProgress: UILabel!
    
    let viewModel = VideoPreviewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let path = Bundle.main.path(forResource: "Movie", ofType:"mp4") else {
            debugPrint("Movie.mp4 not found")
            return
        }
        videoPlayerView.configure(url: path)
    }

    func setupView() {
        btnPlay.layer.cornerRadius = 8
        btnPlay.clipsToBounds = true
        btnPlay.backgroundColor = .red
        btnPlay.setTitle("Start", for: .normal)
        btnPlay.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btnPlay.setTitleColor(UIColor.white, for: .normal)
        btnPlay.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    @IBAction func btnPlayTapped(_ sender: Any) {
        videoPlayerView.playPause()
    }
}



extension VideoPreviewViewController: DownloadDelegate {
    func downloadProgressUpdate(for progress: Float) {
        
    }
}
