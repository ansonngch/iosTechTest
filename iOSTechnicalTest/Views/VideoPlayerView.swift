//
//  VideoPlayerView.swift
//  iOSTechnicalTest
//
//  Created by Anson on 24/9/19.
//  Copyright © 2019 Lomotif. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VideoPlayerView: UIView {
    
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var sliderTime: UISlider!
    
    var playerLayer: AVPlayerLayer?
    var player: AVPlayer?
    var isLoop: Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func configure(url: URL) {
        player = AVPlayer(url: url)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        
        if let playerLayer = self.playerLayer {
            layer.addSublayer(playerLayer)
            overlayView.backgroundColor = UIColor.white.withAlphaComponent(0.2)
            overlayView.isHidden = false
            bringSubviewToFront(overlayView)
        }
        
        player?.addObserver(self,
                            forKeyPath: "currentItem.loadedTimeRanges",
                            options: .new ,
                            context: nil)

        let interval = CMTime(seconds: 1, preferredTimescale: 2)
        player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (time) in
            let seconds = CMTimeGetSeconds(time)
            
            if let duration = self.player?.currentItem?.duration {
                let durationSeconds = CMTimeGetSeconds(duration)
                
                self.sliderTime.value = Float(seconds / durationSeconds)
            }
        })
        
        player?.play()
    }
    
    func playPause() {
        player?.isPlaying ?? true ? pause() : play()
    }
    
    func play() {
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
    
    func stop() {
        player?.seek(to: CMTime.zero)
        pause()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            if let duration = player?.currentItem?.duration {
                let seconds = CMTimeGetSeconds(duration)
                guard !(seconds.isNaN || seconds.isInfinite) else {return}
                
                let secondsText = Int(seconds.truncatingRemainder(dividingBy: 60))
                let minutes = Int(seconds) / 60
                let time = String(format: "%d:%02ds", minutes, secondsText)
                self.lblTimer.text = time
            }
        }
    }

    @IBAction func valueChanged(_ sender: UISlider) {
        if let duration = player?.currentItem?.duration {
            let seconds = CMTimeGetSeconds(duration)
            
            let slideToValue = Float64(sender.value) * seconds
            let seekTime = CMTime(value: Int64(slideToValue), timescale: 1)
            
            player?.seek(to: seekTime, completionHandler: { (finished) in
                
            })
        }
    }
}

extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}
