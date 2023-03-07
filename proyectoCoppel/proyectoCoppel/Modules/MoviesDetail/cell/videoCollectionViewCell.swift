//
//  videoCollectionViewCell.swift
//  proyectoCoppel
//
//  Created by Israel Macbook on 06/03/23.
//

import UIKit
import AVFoundation
import youtube_ios_player_helper
class videoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var viewVideo: YTPlayerView!
    var avQueuePlayer   : AVQueuePlayer?
    var avPlayerLayer   : AVPlayerLayer?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func addPlayer(url: String) {
        viewVideo.load(withVideoId: url)
    }
}
