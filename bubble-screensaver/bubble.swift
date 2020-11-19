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
    
        var videoView:NSView!
        let frameRate = 29.97
        var player:AVPlayer!
    
    var playerLooper: AVPlayerLooper!
    var queuePlayer: AVQueuePlayer!
    var playerLayer:AVPlayerLayer!


        // MARK: - Initialization

        override init?(frame: NSRect, isPreview: Bool) {
            super.init(frame: frame, isPreview: isPreview)
            
            self.animationTimeInterval = 1.0 / frameRate

            guard let soapBubblePath = Bundle(for: type(of: self)).path(forResource: "SoapBubble1080p", ofType: "mov") else {
                fatalError("path to bubble not found")
            }

            let fileURL = URL(fileURLWithPath: soapBubblePath)
            let asset = AVAsset(url: fileURL)
            let playerItem = AVPlayerItem(asset: asset)
            
            self.queuePlayer = AVQueuePlayer(items: [playerItem])
            self.playerLooper = AVPlayerLooper(player: self.queuePlayer, templateItem: playerItem)
            self.playerLayer = AVPlayerLayer(player: self.queuePlayer)
            //self.layer?.addSublayer(self.playerLayer)
            //self.playerLayer.frame = self.frame
            
            //playerLayer.videoGravity = AVLayerVideoGravity.resizeAspect

            let videoView = NSView(frame: NSMakeRect(0, 0, NSWidth(frame)/2, NSHeight(frame)/2))
            videoView.wantsLayer = true

            
            //centerView(self, inView: videoView)
            
            self.playerLayer.frame = videoView.frame
            videoView.layer = self.playerLayer

            //videoView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

            
            self.addSubview(videoView)


            
            //centerView(videoView, inView: self)

            //loop
            //player.actionAtItemEnd = .none
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
    
    @objc func restartVideo() {
        let seconds:Int64 = 0
        let preferredTimeScale:Int32 = 1
        let seekTime:CMTime = CMTimeMake(value: seconds, timescale: preferredTimeScale)
        player.seek(to: seekTime)
        player.play()
    }
    
    func centerView(_ v1:NSView, inView v2:NSView) {
        
//        v1.translatesAutoresizingMaskIntoConstraints = false
//        v2.translatesAutoresizingMaskIntoConstraints = false
//        let equalWidth = NSLayoutConstraint(item: v1,
//                                       attribute:NSLayoutConstraint.Attribute.width,
//                                       relatedBy:NSLayoutConstraint.Relation.equal,
//                                          toItem: v2,
//                                       attribute:NSLayoutConstraint.Attribute.width,
//                                       multiplier:0.75,
//                                      constant:0);
//        let equalHeight = NSLayoutConstraint(item: v1,
//                                        attribute:NSLayoutConstraint.Attribute.height,
//                                        relatedBy:NSLayoutConstraint.Relation.equal,
//                                           toItem: v2,
//                                        attribute:NSLayoutConstraint.Attribute.height,
//                                        multiplier:0.75,
//                                         constant:0);
//        let centerX = NSLayoutConstraint(item: v1,
//                                    attribute:NSLayoutConstraint.Attribute.centerX,
//                                    relatedBy:NSLayoutConstraint.Relation.equal,
//                                       toItem: v2,
//                                    attribute:NSLayoutConstraint.Attribute.centerX,
//                                   multiplier:1.0,
//                                     constant:0);
//        let centerY = NSLayoutConstraint(item: v1,
//                                    attribute:NSLayoutConstraint.Attribute.centerY,
//                                    relatedBy:NSLayoutConstraint.Relation.equal,
//                                       toItem: v2,
//                                    attribute:NSLayoutConstraint.Attribute.centerY,
//                                   multiplier:1.0,
//                                     constant:0);
//
//        v2.addConstraint(equalWidth)
//        v2.addConstraint(equalHeight)
//        v2.addConstraint(centerX)
//        v2.addConstraint(centerY)
        v1.centerXAnchor.constraint(equalTo: v2.centerXAnchor).isActive = true
    }
}
