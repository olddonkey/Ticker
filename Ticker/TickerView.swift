//
//  TickerView.swift
//  Ticker
//
//  Created by olddonkey on 2017/10/10.
//  Copyright © 2017年 olddonkey. All rights reserved.
//

import UIKit

class TickerView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    let DEFAULT_TEXT_SIZE = 12
    let DEFAULT_TEXT_COLOR = UIColor.black
    let DEFAULT_ANIMATION_DURATION = 0.3
    
    lazy var metrics: TickerDrawMetrics = TickerDrawMetrics(font: UIFont.systemFont(ofSize: DEFAULT_TEXT_SIZE))
    lazy var columnManager = TickerColumnManager(metrics: metrics)
}
