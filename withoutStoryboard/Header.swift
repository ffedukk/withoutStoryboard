//
//  Header.swift
//  withoutStoryboard
//
//  Created by 18592232 on 23.07.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import UIKit

struct Header {
    var title: String?
    var topColor: UIColor = .white
    var bottomColor: UIColor  = .white
    
    
    init(title: String? = nil, topColor: UIColor, bottomColor: UIColor) {
        self.title = title
        self.topColor = topColor
        self.bottomColor = bottomColor
    }
}
