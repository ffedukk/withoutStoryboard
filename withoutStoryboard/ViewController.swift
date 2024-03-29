//
//  ViewController.swift
//  withoutStoryboard
//
//  Created by 18592232 on 21.07.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
//    MARK: Properties
    
    var showButton = UIButton(type: .system)
    var tableView = UITableView(frame: .zero)
    
    let cellHeigh: CGFloat = 100
    let headerHeigh: CGFloat = 50
    
    let presenter = Presenter()
    var listOfSections = SectionsList()

//    MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createItems()
        
        view.backgroundColor = .white
        title = "kuku"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit,
                                                           target: self,
                                                           action: #selector(editButtonPressed))
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(MyCustomHeader.self, forHeaderFooterViewReuseIdentifier: "sectionHeader")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.reloadData()
        
        showButton.setTitle("Show", for: .normal)
        showButton.backgroundColor = .systemGreen
        showButton.tintColor = .white
        showButton.layer.cornerRadius = 15
        showButton.isEnabled = false
        showButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(showButton)
        
        showButton.addTarget(self, action: #selector(showButtonPressed), for: .touchUpInside)
        enableButton()
        
        constraintsInit()
    }
    
    
    // MARK: Constraints
    
    func constraintsInit() {
        NSLayoutConstraint.activate([
            showButton.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor,
                                            constant: 20),
            showButton.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor,
                                             constant: -20),
            showButton.bottomAnchor.constraint(equalTo: view.readableContentGuide.bottomAnchor,
                                           constant: -10),
            
            tableView.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: showButton.topAnchor,
                                              constant: -20),
        ])
    }
        
//    MARK: ButtonMethods
    
    @objc func showButtonPressed() {
        listOfSections.showingEnabled()
        tableView.reloadData()
    }
    
    @objc func editButtonPressed() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                            target: self,
                                                            action: #selector(doneButtonPressed))
        navigationItem.leftBarButtonItems?.remove(at: navigationItem.leftBarButtonItems!.count - 1)
        tableView.setEditing(true, animated: true)
        
    }
    
    @objc func doneButtonPressed() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit,
                                                           target: self,
                                                           action: #selector(editButtonPressed))
        navigationItem.rightBarButtonItems?.remove(at: navigationItem.leftBarButtonItems!.count - 1)
        tableView.setEditing(false, animated: true)
    }
}

// MARK: CellDelegateProtocol Methods

extension ViewController: CellDelegateProtocol {
    
    func updateListOfSections(with model: TextModel, section: Int, row: Int) {
        listOfSections.updateList(with: model, section: section, row: row)
    }
    
    func enableButton() {
        var flag = false
        for section in listOfSections.listOfSections{
            for model in section.listOfModels {
                if model.textFieldText.count >= 5 && model.textFieldText.count <= 15 {
                    flag = true
                }
            }
        }
        showButton.isEnabled = flag
    }
}

//MARK: HeaderDelegateProtocol

extension ViewController: HeaderDelegateProtocol {
    func addRowInSection(section: Int) {
        let newModel = TextModel(text: "")
        listOfSections.insertModelInSection(model: newModel, section: section, row: 0)
        tableView.insertRows(at: [IndexPath(row: 0, section: section)], with: .top)
    }
    
    func deleteRowFromSection(section: Int) {
        if !listOfSections.isSectionEmpty(section: section) {
            listOfSections.removeModelInSection(section: section, model: 0)
            tableView.deleteRows(at: [IndexPath(row: 0, section: section)], with: .top)
        }
    }
}

//MARK: UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return listOfSections.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfSections.NumberOfModels(at: section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionHeader") as! MyCustomHeader
        header.delegate = self
        let currentSectionModel = listOfSections.retrieveSection(with: section)
        header.setHeader(with: currentSectionModel, width: tableView.frame.size.width, height: headerHeigh, sectionIndex: section)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.delegate = self
        let model = listOfSections.retrieveSection(with: indexPath.section).retrieveModelWithIndex(index: indexPath.row)
        cell.setCell(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeigh
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeigh
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

//MARK: UITableViewDelegate Methods

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let selectedModel = listOfSections.removeModelInSection(section: sourceIndexPath.section,
                                                                model: sourceIndexPath.row)
        listOfSections.insertModelInSection(model: selectedModel,
                                            section: destinationIndexPath.section,
                                            row: destinationIndexPath.row)
    }
}

//MARK: Data

extension ViewController {
    func createItems() {
        let color_1 = UIColor(displayP3Red: 1, green: 0.5, blue: 0.3, alpha: 1)
        let color_2 = UIColor(displayP3Red: 0.9, green: 0.8, blue: 0.2, alpha: 0.5)
        let color_3 = UIColor(displayP3Red: 0.5, green: 0.8, blue: 0.2, alpha: 1)
        let color_4 = UIColor(displayP3Red: 0.2, green: 1, blue: 0.6, alpha: 0.5)
        let color_5 = UIColor(displayP3Red: 0.7, green: 0.15, blue: 0.7, alpha: 1)
        let color_6 = UIColor(displayP3Red: 1, green: 0.15, blue: 0.7, alpha: 0.5)
        
        listOfSections = SectionsList()
        var modelList_1: [TextModel] = []
        let header_1 = Header(title: "First Title", topColor: color_1, bottomColor: color_2)
        let model_1 = TextModel(text: "Hello")
        let model_2 = TextModel(text: "World")
        let model_3 = TextModel(text: "!")
        modelList_1.append(contentsOf: [model_1,model_2,model_3])
        
        var modelList_2: [TextModel] = []
        let header_2 = Header(title: "Second Title", topColor: color_3, bottomColor: color_4)
        let model_4 = TextModel(text: "here")
        let model_5 = TextModel(text: "is")
        let model_6 = TextModel(text: "five")
        let model_7 = TextModel(text: "different")
        let model_8 = TextModel(text: "rows")
        modelList_2.append(contentsOf: [model_4,model_5,model_6,model_7,model_8])
        
        var modelList_3: [TextModel] = []
        let header_3 = Header(title: "The last title", topColor: color_5, bottomColor: color_6)
        let model_9 = TextModel(text: "here")
        let model_10 = TextModel(text: "we")
        let model_11 = TextModel(text: "have")
        let model_12 = TextModel(text: "four")
        modelList_3.append(contentsOf: [model_9,model_10,model_11,model_12])
        
        var sectionList: [Section] = []
        let section_1 = Section(models: modelList_1, header: header_1)
        let section_2 = Section(models: modelList_2, header: header_2)
        let section_3 = Section(models: modelList_3, header: header_3)
        sectionList.append(contentsOf: [section_1,section_2,section_3])
        
        listOfSections.append(sectionList)
    }
}
