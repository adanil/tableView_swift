//
//  filmCell.swift
//  TableHW
//
//  Created by Даниил Автушко on 17.03.2021.
//

import Foundation
import SwiftUI

class filmCell : UITableViewCell{
    private var nameLabel = UILabel()
    var rightArrow = UIImage()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(nameLabel)
        layoutConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutConstraints(){
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25)
            
        ])
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        

    }
    
    
    
    public func setTextCell(text: String){
        nameLabel.text = text
        print(text)
    }
}
