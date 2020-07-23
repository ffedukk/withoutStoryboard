//
//  Presenter.swift
//  withoutStoryboard
//
//  Created by 18592232 on 21.07.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import Foundation

class Presenter {
    func check(text: String) -> (textToShow: String,isError: Bool) {
        let count = text.count
        if count < 5 {
            return ("Must be longer than 5",true)
        }
        if count > 15 {
            return ("Must be fewer than 15",true)
        }
        return (text,false)
    }
    
    func anotherCheck(text: String, completion: ()->Void, onFailure: ()->Void) {
        let count = text.count
        if count < 5 || count > 15 {
            onFailure()
        } else {
            completion()
        }
    }
//    func anotherCheck(text: String, completion: ()->Void, onFailure: (Bool)->Void) {
//        let count = text.count
//        var isFewer: Bool
//        if count < 5 {
//            isFewer = true
//            onFailure(isFewer)
//        } else if count > 15 {
//            isFewer = false
//            onFailure(isFewer)
//        } else {
//            completion()
//        }
//    }
}
