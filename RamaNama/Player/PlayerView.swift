import Foundation
import SwiftUI
import YouTubeiOSPlayerHelper

final class PlayerView: UIViewRepresentable {
    
    let playerView = YTPlayerView()
    var videoId: String
    weak var delegate: YTPlayerViewDelegate?
    
    init(videoId: String, delegate: YTPlayerViewDelegate) {
        self.videoId = videoId
        self.delegate = delegate
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
       play()
    }
    
    func makeUIView(context: Context) -> some UIView {
        return playerView
    }
    
    func makeCoordinator() -> () {
        
    }
    
    func play() {
        playerView.load(withVideoId: videoId)
        let vars: [AnyHashable: Any] = [
            "start": 0,
            "rel": 0,
            "modestbranding": 1,
            "fs": 0
        ]
        playerView.load(withVideoId: videoId, playerVars: vars)
    }
}

class PlayerDelegate: NSObject, YTPlayerViewDelegate {
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        switch state {
        case .unstarted:
            print("default")
        case .ended:
            print("ended")
        case .playing:
            print("playing")
        case .paused:
            print("paused")
        case .buffering:
            print("buffering")
        case .cued:
            print("cued")
        case .unknown:
            print("unknwn")
        @unknown default:
            print("default")
        }
    }

    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
    
    func playerView(_ playerView: YTPlayerView, receivedError error: YTPlayerError) {
        
    }
}
