import Foundation
import SwiftUI
import YouTubeiOSPlayerHelper

final class PlayerView: UIViewRepresentable {
    
    let playerView = YTPlayerView()
    var videoId: String
    private var delegate: YTPlayerViewDelegate?
    
    init(videoId: String) {
        self.videoId = videoId
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        playerView.delegate = delegate
        play()
    }
    
    func makeUIView(context: Context) -> some UIView {
        return playerView
    }
    
    func makeCoordinator() -> Coordinator {
        let coordinator = Coordinator()
        delegate = coordinator
        return coordinator
    }
    
    func play() {
        let vars: [AnyHashable: Any] = [
            "start": 0,
            "rel": 0,
            "modestbranding": 1,
            "fs": 0
        ]
        playerView.load(withVideoId: videoId, playerVars: vars)
    }
    
    static func dismantleUIView(_ uiView: PlayerView, coordinator: Coordinator) {
        print("Dismantle")
    }
    
    class Coordinator: NSObject, YTPlayerViewDelegate {
        override init() {
            super.init()
            print("---> delegate init()")
        }
        func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
            switch state {
            case .unstarted:
                print("--->default")
            case .ended:
                print("--->ended")
            case .playing:
                print("--->playing")
            case .paused:
                print("--->paused")
            case .buffering:
                print("--->buffering")
            case .cued:
                print("--->cued")
            case .unknown:
                print("--->unknwn")
            @unknown default:
                print("--->default")
            }
        }

        func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
            playerView.playVideo()
        }
        
        func playerView(_ playerView: YTPlayerView, receivedError error: YTPlayerError) {
            
        }
    }
}
