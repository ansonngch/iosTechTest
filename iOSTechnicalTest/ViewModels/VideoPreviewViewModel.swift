//
//  VideoPreviewViewModel.swift
//  iOSTechnicalTest
//
//  Created by Anson on 24/9/19.
//  Copyright © 2019 Lomotif. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AVKit
import AssetsLibrary

class VideoPreviewViewModel: NSObject {
    lazy var downloadsSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        
        return URLSession(configuration: configuration,
                          delegate: self,
                          delegateQueue: nil)
    }()
    
    var track: URLFile?
    
    /// Get local file path: download task stores tune here; AV player plays it.
    let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    var activeDownloads: [URL: Download] = [:]
    var videoMerged: ((_ video: URL) -> Void)?
    var downloadProgress: ((_ progress: Float, _ totalSize: String) -> Void)?
    
    
    func localFilePath(for url: URL) -> URL {
        return documentsPath.appendingPathComponent(url.lastPathComponent)
    }
    
    func downloadFile() {
        let url = URL(string: "https://audio-ssl.itunes.apple.com/apple-assets-us-std-000001/AudioPreview122/v4/8a/dd/1f/8add1f4d-142c-1317-250d-ff6370962fb8/mzaf_7601694821840779604.plus.aac.p.m4a")
        if let url = url {
            self.track = URLFile(previewURL: url)
            
            if let track = track {
                let download = Download(track: track)
                // 2
                download.task = downloadsSession.downloadTask(with: track.previewURL)
                // 3
                download.task?.resume()
                // 4
                download.isDownloading = true
                // 5
                activeDownloads[track.previewURL] = download
            }
        }
    }
    
    func mergeVideoAndAudio(videoUrl: URL,
                            audioUrl: URL,
                            shouldFlipHorizontally: Bool = false,
                            completion: @escaping (_ error: Error?, _ url: URL?) -> Void) {
        
        let mixComposition = AVMutableComposition()
        var mutableCompositionVideoTrack = [AVMutableCompositionTrack]()
        var mutableCompositionAudioTrack = [AVMutableCompositionTrack]()
        var mutableCompositionAudioOfVideoTrack = [AVMutableCompositionTrack]()
        
        //start merge
        
        let aVideoAsset = AVAsset(url: videoUrl)
        let aAudioAsset = AVAsset(url: audioUrl)
        
        let compositionAddVideo = mixComposition.addMutableTrack(withMediaType: AVMediaType.video,
                                                                 preferredTrackID: kCMPersistentTrackID_Invalid)
        
        let compositionAddAudio = mixComposition.addMutableTrack(withMediaType: AVMediaType.audio,
                                                                 preferredTrackID: kCMPersistentTrackID_Invalid)
        
        let compositionAddAudioOfVideo = mixComposition.addMutableTrack(withMediaType: AVMediaType.audio,
                                                                        preferredTrackID: kCMPersistentTrackID_Invalid)
        
        let aVideoAssetTrack: AVAssetTrack = aVideoAsset.tracks(withMediaType: AVMediaType.video)[0]
        let aAudioOfVideoAssetTrack: AVAssetTrack? = aVideoAsset.tracks(withMediaType: AVMediaType.audio).first
        let aAudioAssetTrack: AVAssetTrack = aAudioAsset.tracks(withMediaType: AVMediaType.audio)[0]
        
        // Default must have tranformation
        compositionAddVideo?.preferredTransform = aVideoAssetTrack.preferredTransform
        
        if shouldFlipHorizontally {
            // Flip video horizontally
            var frontalTransform: CGAffineTransform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            frontalTransform = frontalTransform.translatedBy(x: -aVideoAssetTrack.naturalSize.width, y: 0.0)
            frontalTransform = frontalTransform.translatedBy(x: 0.0, y: -aVideoAssetTrack.naturalSize.width)
            compositionAddVideo?.preferredTransform = frontalTransform
        }
        
        if let video = compositionAddVideo, let audio = compositionAddAudio, let mix = compositionAddAudioOfVideo {
            mutableCompositionVideoTrack.append(video)
            mutableCompositionAudioTrack.append(audio)
            mutableCompositionAudioOfVideoTrack.append(mix)
        }
    
        do {
            let duration = min(aVideoAssetTrack.timeRange.duration, aAudioAssetTrack.timeRange.duration)
            
            try mutableCompositionVideoTrack[0].insertTimeRange(CMTimeRangeMake(start: CMTime.zero,
                                                                                duration: duration),
                                                                of: aVideoAssetTrack,
                                                                at: CMTime.zero)
            
            try mutableCompositionAudioTrack[0].insertTimeRange(CMTimeRangeMake(start: CMTime.zero,
                                                                                duration: duration),
                                                                of: aAudioAssetTrack,
                                                                at: CMTime.zero)
            
            // adding audio (of the video if exists) asset to the final composition
            if let aAudioOfVideoAssetTrack = aAudioOfVideoAssetTrack {
                try mutableCompositionAudioOfVideoTrack[0].insertTimeRange(CMTimeRangeMake(start: CMTime.zero,
                                                                                           duration: duration),
                                                                           of: aAudioOfVideoAssetTrack,
                                                                           at: CMTime.zero)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        // Exporting
        let savePathUrl: URL = URL(fileURLWithPath: NSHomeDirectory() + "/Documents/newVideo.mp4")
        do { // delete old video
            try FileManager.default.removeItem(at: savePathUrl)
        } catch { print(error.localizedDescription) }
        
        let assetExport: AVAssetExportSession = AVAssetExportSession(asset: mixComposition, presetName: AVAssetExportPresetHighestQuality)!
        assetExport.outputFileType = AVFileType.mp4
        assetExport.outputURL = savePathUrl
        assetExport.shouldOptimizeForNetworkUse = true
        
        assetExport.exportAsynchronously { () -> Void in
            switch assetExport.status {
            case AVAssetExportSessionStatus.completed:
                print("success")
                completion(nil, savePathUrl)
            case AVAssetExportSessionStatus.failed:
                print("failed \(assetExport.error?.localizedDescription ?? "error nil")")
                completion(assetExport.error, nil)
            case AVAssetExportSessionStatus.cancelled:
                print("cancelled \(assetExport.error?.localizedDescription ?? "error nil")")
                completion(assetExport.error, nil)
            default:
                print("complete")
                completion(assetExport.error, nil)
            }
        }
        
    }
}

extension VideoPreviewViewModel: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        guard let sourceURL = downloadTask.originalRequest?.url else {
            return
        }
        
        let download = activeDownloads[sourceURL]
        activeDownloads[sourceURL] = nil

        let destinationURL = localFilePath(for: sourceURL)
        print(destinationURL)
        
        let fileManager = FileManager.default
        try? fileManager.removeItem(at: destinationURL)
        
        do {
            try fileManager.copyItem(at: location, to: destinationURL)
            download?.track?.downloaded = true
            
            guard let path = Bundle.main.path(forResource: "Movie", ofType:"mp4") else {
                debugPrint("Movie.mp4 not found")
                return
            }
            guard let audio = download?.track?.previewURL else { return }
            
            let videoPath = URL(fileURLWithPath: path)
            
            self.mergeVideoAndAudio(videoUrl: videoPath, audioUrl: audio) { (error, url) in
                if let url = url {
                    self.videoMerged?(url)
                }
            }
            
        } catch let error {
            print("Could not copy file to disk: \(error.localizedDescription)")
        }
    }
    
    func prepareToMerge() {
        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        guard let url = downloadTask.originalRequest?.url,
            let download = activeDownloads[url] else { return }
        
        download.progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        
        let totalSize = ByteCountFormatter.string(fromByteCount: totalBytesExpectedToWrite, countStyle: .file)
        
        DispatchQueue.main.async {
            self.downloadProgress?(download.progress, totalSize)
        }
    }
}
