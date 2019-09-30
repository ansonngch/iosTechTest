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
        
        viewModel.downloadProgress = {[weak self] (progress, total) in
            self?.lblProgress.text = String(format: "%.1f%%", progress * 100)
        }
        
        viewModel.videoMerged = {[weak self] (url) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05, execute: {
                self?.videoPlayerView.configure(url: url)
            })
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        videoPlayerView.stop()
    }

    func setupView() {
        btnPlay.layer.cornerRadius = 8
        btnPlay.clipsToBounds = true
        btnPlay.backgroundColor = .red
        btnPlay.setTitle("Start", for: .normal)
        btnPlay.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btnPlay.setTitleColor(UIColor.white, for: .normal)
        btnPlay.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        videoPlayerView.overlayView.isHidden = true
        videoPlayerView.backgroundColor = .black
    }
    
    @IBAction func btnPlayTapped(_ sender: Any) {
        if (viewModel.track?.downloaded ?? false) == false {
            viewModel.downloadFile()
        } else {
            videoPlayerView.playPause()
        }
        
    }
}

extension VideoPreviewViewController: DownloadDelegate {
    func downloadProgressUpdate(for progress: Float) {
        
    }
}

