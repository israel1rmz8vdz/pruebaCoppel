//
//  ProgressIIndicator.swift
//  proyectoCoppel
//
//  Created by Israel Macbook on 06/03/23.
//

import Foundation
import UIKit
class ProgressIIndicator: UIView {
    var progressIndicatorView: UIVisualEffectView?
    override init(frame: CGRect) {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = frame
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.progressIndicatorView = blurEffectView
        super.init(frame: frame)
        addSubview(blurEffectView)
        addLoader()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init()")
    }
    private func addLoader() {
        guard let blurEffectView = progressIndicatorView else { return }
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        blurEffectView.contentView.addSubview(activityIndicator)
        activityIndicator.center = blurEffectView.contentView.center
        activityIndicator.startAnimating()
    }
}
