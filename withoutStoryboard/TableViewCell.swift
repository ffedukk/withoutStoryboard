//
//  TableViewCell.swift
//  withoutStoryboard
//
//  Created by 18592232 on 21.07.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import UIKit

//MARK: CellDelegateProrocol

protocol CellDelegateProtocol: class {
    func updateListOfSections(with model: TextModel, section: Int, row: Int)
    func enableButton()
}

class TableViewCell: UITableViewCell{

//    MARK: Properties
    
    var textField = UITextField(frame: .zero)
    var errorLabel = UILabel(frame: .zero)
    var textToShowLabel = UILabel(frame: .zero)
    
    weak var delegate: CellDelegateProtocol?
    
//    MARK: Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")

        errorLabel.textColor = .red
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(errorLabel)
        
        textToShowLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textToShowLabel)
        
        textField.placeholder = "Something important"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
        
        textField.addTarget(self, action: #selector(textEdited), for: .editingChanged)
        
        constraintsInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    MARK: Constraints
    
    func constraintsInit() {
        NSLayoutConstraint.activate([
          textField.topAnchor.constraint(equalTo: contentView.readableContentGuide.topAnchor),
          textField.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor, constant: 20),
          textField.trailingAnchor.constraint(equalTo: contentView.readableContentGuide.trailingAnchor, constant: -20),

          errorLabel.topAnchor.constraint(equalTo: textField.bottomAnchor),
          errorLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

          textToShowLabel.topAnchor.constraint(equalTo: errorLabel.bottomAnchor),
          textToShowLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
    
//    MARK: Logic Methods
    
    @objc func textEdited() {
        if let userText = textField.text,
            let supewView = self.superview as? UITableView,
            let section = supewView.indexPath(for: self)?.section,
            let row = supewView.indexPath(for: self)?.row {
            
            let model = TextModel(text: userText)
            setCell(with: model)
            delegate?.updateListOfSections(with: model, section: section, row: row)
            delegate?.enableButton()
        }
    }
    
    func setCell(with model: TextModel) {
        textField.text = model.textFieldText
        errorLabel.text = model.errorLabelText
        if model.isShowingTextEnable {
            textToShowLabel.text = model.textFieldText
        } else {
            textToShowLabel.text = ""
        }
    }
    
    deinit {
        print("deolocated")
    }
    
}
