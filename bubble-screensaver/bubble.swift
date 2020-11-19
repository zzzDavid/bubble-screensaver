//
//  main.swift
//  bubble-screensaver
//
//  Created by Niansong Zhang on 2020-11-19.
//

import ScreenSaver
import AVFoundation
import AVKit

class bubble: ScreenSaverView {
    
    var playerLooper: AVPlayerLooper!
    var queuePlayer: AVQueuePlayer!
    var playerLayer:AVPlayerLayer!
    var videoView: NSView!


        // MARK: - Initialization

        override init?(frame: NSRect, isPreview: Bool) {
            super.init(frame: frame, isPreview: isPreview)

            guard let soapBubblePath = Bundle(for: type(of: self)).path(forResource: "SoapBubble1080p", ofType: "mov") else {
                fatalError("path to bubble not found")
            }

            let fileURL = URL(fileURLWithPath: soapBubblePath)
            let asset = AVAsset(url: fileURL)
            let playerItem = AVPlayerItem(asset: asset)
            
            self.queuePlayer = AVQueuePlayer(items: [playerItem])
            self.playerLooper = AVPlayerLooper(player: self.queuePlayer, templateItem: playerItem)
            self.playerLayer = AVPlayerLayer(player: self.queuePlayer)

            //let videoView = NSView(frame: NSMakeRect(frame.minX + NSWidth(frame)/4, frame.minY + NSHeight(frame)/4, NSWidth(frame)/2, NSHeight(frame)/2))
            self.videoView = NSView(frame: NSMakeRect(0, 0, NSWidth(frame)/2, NSHeight(frame)/2))
            self.videoView.wantsLayer = true
            self.playerLayer.frame = videoView.frame
            self.videoView.layer = self.playerLayer
        

            
            
            self.addSubview(self.videoView)
            
            // note: when you turn the subview's translateAutoresizingMaskIntoConstriants option off,
            // you have to specify a whole set of layout constraint for the subview.
            // also, don't turn superview's switch off.
            
            videoView.translatesAutoresizingMaskIntoConstraints = false
            self.videoView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            self.videoView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            self.videoView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
            self.videoView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
            
        }

    
        @available(*, unavailable)
        required init?(coder decoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        // MARK: - Lifecycle

        override func draw(_ rect: NSRect) {

            self.queuePlayer.play()
        }

    
        override func animateOneFrame() {
            super.animateOneFrame()
            setNeedsDisplay(bounds)
        }
    

    
}
