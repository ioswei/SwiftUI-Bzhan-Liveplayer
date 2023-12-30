//
//  ContentView.swift
//  DemoTst
//
//  Created by 000 on 2023/12/11.
//

import SwiftUI
import IJKMediaFramework

struct PlayLiveView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return PlayerView(frame: CGRect(x: 0 , y: 50, width: 200, height: 200))
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}

class PlayerView: UIView {
    
    var player: IJKFFMoviePlayerController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let options = IJKFFOptions.byDefault()
        let url = URL(string: "rtmp://mobliestream.c3tv.com:554/live/goodtv.sdp")
        player = IJKFFMoviePlayerController(contentURL: url, with: options)
        player?.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        player?.view.frame = frame
        player?.scalingMode = .aspectFill
        player?.shouldAutoplay = true
        self.autoresizesSubviews = true
        self.addSubview(player!.view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if self.superview == nil {
            player?.shutdown()
        } else {
            player?.prepareToPlay()
        }
    }
}

struct ContentView: View {
    @State private var emailAddress: String = ""
    @State private var isSecure: Bool = false
    var body: some View {
        VStack {
            PlayLiveView().padding(20)
        }
    }
}
