//
//  WaterButton.swift
//  SwiftUI06--collectionview实现的瀑布流
//
//  Created by liutao on 17/4/5.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

import UIKit

class WaterButton: UIButton {

    var wImage:UIImage! {
    
        didSet {
        wImageView.image = wImage
        }
    
    }
    private var wImageView:UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        wImageView = UIImageView(frame: bounds)
        addSubview(wImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        wImageView.frame = bounds
    }
    
}
