//
//  SectionModelList.swift
//  withoutStoryboard
//
//  Created by 18592232 on 22.07.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import Foundation

struct SectionsList {
    var listOfSections : [TextModelList] = []
    
    init(){
        listOfSections = []
    }
    
    init(numberOfSections: Int, with rows: Int){
        for _ in 0..<numberOfSections {
            let section = TextModelList(numberOfModels: rows)
            listOfSections.append(section)
        }
    }
    
    mutating func append(_ section: TextModelList) {
        listOfSections.append(section)
    }
    
    func retrieveSection(with index: Int) -> TextModelList {
        return listOfSections[index]
    }
    
    func numberOfSections() -> Int {
        return listOfSections.count
    }
    
    mutating func showingEnabled(){
        listOfSections = listOfSections.map { section -> TextModelList in
            var switchSection = section
            switchSection.showingEnabled()
            return switchSection
        }
    }
    
    mutating func updateList(with model: TextModel, section: Int, row: Int) {
        listOfSections[section].listOfModels[row] = model
    }
}
