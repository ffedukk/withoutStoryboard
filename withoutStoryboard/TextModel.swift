//
//  TextModel.swift
//  withoutStoryboard
//
//  Created by 18592232 on 21.07.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import Foundation

struct TextModel {
    var errorLabelText = ""
    var textFieldText = ""
    var showedText = ""
    var isShowingTextEnable = false
    
    init(text: String) {
        textFieldText = text
        if text.count < 5 {
            errorLabelText = "Must be longer than 5"
        } else if text.count > 15 {
            errorLabelText = "Must be fewer than 15"
        }
    }
    
    mutating func switchShowing() {
        if textFieldText.count < 5 || textFieldText.count > 15 {
            isShowingTextEnable = false
        } else {
            isShowingTextEnable = true
        }
    }
}
