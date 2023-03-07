//
//  videoCollectionViewCell.swift
//  proyectoCoppel
//
//  Created by Israel Macbook on 06/03/23.
//

import UIKit
import AVFoundation

class videoCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var avQueuePlayer   : AVQueuePlayer?
        var avPlayerLayer   : AVPlayerLayer?

//        func addPlayer(for url: URL) {
//            self.avQueuePlayer = AVQueuePlayer(url: url)
//            self.avPlayerLayer = AVPlayerLayer(player: self.avQueuePlayer!)
//            self.avPlayerLayer?.frame = self.playerView.bounds
//            self.avPlayerLayer?.fillMode = .both
//            self.playerView.layer.addSublayer(self.avPlayerLayer!)
//            self.avQueuePlayer?.play()
//        }
}
