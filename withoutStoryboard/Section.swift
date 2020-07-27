//
//  TextModelList.swift
//  withoutStoryboard
//
//  Created by 18592232 on 21.07.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import Foundation

struct Section {
    var title: String?
    var header: Header?
    
    var listOfModels: [TextModel] = []
    
    init() {
        listOfModels = []
    }
    
    init(numberOfModels: Int, title: String) {
        for _ in 0..<numberOfModels {
            let textModel = TextModel(text: "")
            listOfModels.append(textModel)
        }
        self.title = title
    }
    
    init(models: [TextModel], title: String? = nil){
        listOfModels += models
        self.title = title
    }
    
    init(models: [TextModel], header: Header){
        listOfModels += models
        self.header = header
    }
    
    func numberOfModels() -> Int {
        listOfModels.count
    }
    
    mutating func removeModel(at index: Int) -> TextModel {
        return listOfModels.remove(at: index)
    }
    
    mutating func addModel() {
        let model = TextModel(text: "")
        listOfModels.append(model)
    }
    
    mutating func addModel(model: TextModel) {
        listOfModels.append(model)
    }
    
    func retrieveModelWithIndex(index: Int) -> TextModel {
        return listOfModels[index]
    }
    
    mutating func updateList(with model: TextModel, index: Int) {
        listOfModels[index] = model
        
    }
    
    mutating func showingEnabled() {
        listOfModels = listOfModels.map { model -> TextModel in
            var switchModel = model
            switchModel.switchShowing()
            return switchModel
        }
        
//        var newList: [TextModel] = []
//        listOfModels.forEach { model in
//            var switchModel = model
//            switchModel.switchShowing()
//            newList.append(switchModel)
//        }
//        listOfModels = newList
    }
    
    mutating func setTitle(_ title: String) {
        self.title = title
    }
    
    func isEmpty() -> Bool {
        return listOfModels.isEmpty
    }
    
    mutating func insert(_ model: TextModel, at index: Int) {
        listOfModels.insert(model, at: index)
    }
}
