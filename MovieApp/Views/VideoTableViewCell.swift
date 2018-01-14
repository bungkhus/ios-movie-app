//
//  VideoTableViewCell.swift
//  MovieApp
//
//  Created by bungkhus on 15/01/18.
//  Copyright © 2018 Bungkhus. All rights reserved.
//

import UIKit
import AVFoundation
import youtube_ios_player_helper

class VideoTableViewCell: UITableViewCell {

    @IBOutlet var youtubeView: YTPlayerView!
    @IBOutlet var lableTitle: UILabel!
    
    var videoKey: String = "zNCz4mQzfEI"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        setupVideoPlayer(videoKey: videoKey)
    }
    
    var video: Video? {
        didSet {
            if let video = video, let key = video.key {
                videoKey = key
                setupVideoPlayer(videoKey: videoKey)
                if let title = video.name {
                    lableTitle.text = title
                }
            }
        }
    }
    
    // MARK: METHODS
    
    fileprivate func dismissVideoPlayer() {
        if let youtubeView = youtubeView {
            youtubeView.stopVideo()
            youtubeView.removeWebView()
            youtubeView.delegate = nil
        }
        youtubeView = nil
    }
    
    fileprivate func pauseVideoPlayer() {
        if let youtubeView = youtubeView {
            youtubeView.pauseVideo()
        }
    }
    
    func setupVideoPlayer(videoKey: String) {
        if let youtubeView = youtubeView {
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            } catch let error as NSError {
                print("error: \(error.localizedDescription)")
            }
            
            youtubeView.delegate = self
            let playerVars = [
                "modestbranding" : "1",
                "controls" : "1",
                "playsinline" : "1",
                "autohide" : "1",
                "showinfo" : "1",
                "autoplay" : "0",
                "fs" : "1",
                "rel" : "0",
                "loop" : "0",
                "enablejsapi" : "1",
                "iv_load_policy": "1",
                "origin" : "https://bungkhus.tk"
            ]
            youtubeView.load(withVideoId: videoKey, playerVars: playerVars)
        }
    }

}

extension VideoTableViewCell: YTPlayerViewDelegate {
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        //print("ready")
        playerView.cueVideo(byId: videoKey, startSeconds: playerView.currentTime(), suggestedQuality: .medium)
    }
    
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        switch state {
        case .buffering:
            //            print("buffering")
            break;
        case .ended:
            // end
            break;
        case .paused:
            //            print("paused")
            break;
        case .playing:
            //            print("playing")
            break;
        case .queued:
            //            print("queued")
            break;
        case .unknown:
            //            print("unknown")
            break;
        case .unstarted:
            //            print("unstarted")
            break;
        }
    }
    
    func playerView(_ playerView: YTPlayerView, didChangeTo quality: YTPlaybackQuality) {
        //print("changed")
    }
    
}
