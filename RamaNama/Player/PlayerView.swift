import Foundation
import SwiftUI
import YouTubeiOSPlayerHelper

struct PlayerView: UIViewRepresentable {
    
    let playerView = YTPlayerView()
    var videoId: String
    private var delegate: YTPlayerViewDelegate
    
    init(videoId: String, delegate: YTPlayerViewDelegate) {
        self.videoId = videoId
        self.delegate = delegate
        playerView.delegate = delegate
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        play()
    }
    
    func makeUIView(context: Context) -> some UIView {
        playerView.delegate = delegate
        return playerView
    }
    
    func makeCoordinator() -> Coordinator {
        let coordinator = Coordinator()
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
    
    class Coordinator: NSObject {
        override init() {
            super.init()
        }
    }
}
