//
//  SectionModelList.swift
//  withoutStoryboard
//
//  Created by 18592232 on 22.07.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import Foundation

struct SectionsList {
    var listOfSections : [Section] = []
    
    init(){
        listOfSections = []
    }
    
    init(numberOfSections: Int, with rows: [Int], and title: [String]){
        for index in 0..<numberOfSections {
            let section = Section(numberOfModels: rows[index], title: title[index])
            listOfSections.append(section)
        }
    }
    
    mutating func append(_ section: Section) {
        listOfSections.append(section)
    }
    
    mutating func append(_ sections: [Section]) {
        listOfSections.append(contentsOf: sections)
    }
    
    func retrieveSection(with index: Int) -> Section {
        return listOfSections[index]
    }
    
    func numberOfSections() -> Int {
        return listOfSections.count
    }
    
    func NumberOfModels(at index: Int) -> Int {
        listOfSections[index].numberOfModels()
    }
    
    mutating func showingEnabled(){
        listOfSections = listOfSections.map { section -> Section in
            var switchSection = section
            switchSection.showingEnabled()
            return switchSection
        }
    }
    
    mutating func updateList(with model: TextModel, section: Int, row: Int) {
        listOfSections[section].listOfModels[row] = model
    }
    
    func isSectionEmpty(section: Int) -> Bool {
        return listOfSections[section].isEmpty()
    }
    
    mutating func removeModelInSection(section: Int, model: Int) -> TextModel {
        return listOfSections[section].removeModel(at: model)
    }
    
    mutating func insertModelInSection(model: TextModel, section: Int, row: Int) {
        listOfSections[section].insert(model, at: row)
    }
    
}
