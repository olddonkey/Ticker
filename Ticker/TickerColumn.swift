//
//  TickerColumn.swift
//  Ticker
//
//  Created by olddonkey on 2017/9/18.
//  Copyright © 2017年 olddonkey. All rights reserved.
//

import UIKit

class TickerColumn: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    static let unknown_start_index = -1
    static let unknown_end_index = -2
    
    var characterList: [Character] = [Character]()
    var characterIndicesMap: [Character: Int] = [Character: Int]()
    //var

}
