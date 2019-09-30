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
        
        viewModel.videoMerged = {[weak self] (url) in
            DispatchQueue.main.async {
                self?.videoPlayerView.configure(url: url)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        
        let url = URL(string: "https://audio-ssl.itunes.apple.com/apple-assets-us-std-000001/AudioPreview122/v4/8a/dd/1f/8add1f4d-142c-1317-250d-ff6370962fb8/mzaf_7601694821840779604.plus.aac.p.m4a")
        if let url = url {
            let file = URLFile(previewURL: url)
            viewModel.downloadFile(url: file)
        }
    }
}

extension VideoPreviewViewController: DownloadDelegate {
    func downloadProgressUpdate(for progress: Float) {
        
    }
}

