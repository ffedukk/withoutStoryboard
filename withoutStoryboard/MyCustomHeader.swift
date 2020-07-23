//
//  MyCustomHeader.swift
//  withoutStoryboard
//
//  Created by 18592232 on 23.07.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import UIKit

protocol HeaderDelegateProtocol {
    func addRowInSection(section: Int)
}

class MyCustomHeader: UITableViewHeaderFooterView {
    
    let titleLabel = UILabel()
    let addButton = UIButton(type: .contactAdd)
    
    var topColor = UIColor()
    var bottomColor = UIColor()
    var color = CAGradientLayer()
    
    var delegate: HeaderDelegateProtocol?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        addButton.tintColor = .white
        titleLabel.textColor = .white
        contentView.backgroundColor = .clear

        addButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(addButton)
        contentView.addSubview(titleLabel)
        
        addButton.addTarget(self, action: #selector(addRow), for: .touchUpInside)
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
           
            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            addButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func setHeader(with section: Section, width: CGFloat, height: CGFloat, sectionIndex: Int) {
        if let header = section.header {
            titleLabel.text = header.title
            
            color.colors = [header.topColor.cgColor,header.bottomColor.cgColor]
            color.locations = [0.0,1.0]
            self.contentView.layer.insertSublayer(color, at: 0)
            color.frame = CGRect(x: 0, y: 0, width: width, height: height)
            addButton.tag = sectionIndex
        }
        
    }
    
    @objc func addRow() {
        delegate?.addRowInSection(section: addButton.tag)
    }
}
