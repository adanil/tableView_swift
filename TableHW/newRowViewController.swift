//
//  newRowViewController.swift
//  TableHW
//
//  Created by Даниил Автушко on 20.03.2021.
//

import Foundation
import SwiftUI

class newRowViewController : UIViewController{
    private var textField : UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.becomeFirstResponder()
        textField.returnKeyType = UIReturnKeyType.done
        return textField
    }()
    weak var delegate: myViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        textField.addTarget(self, action: #selector(saveRecord), for: .touchDragEnter)
        
        view.addSubview(textField)
        textField.delegate = self
        layoutConstraints()
        
        
    }
    
    private func layoutConstraints(){
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
//            textField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    @objc func saveRecord(){
        var record : String = textField.text ?? "default"
        print(record)
        textField.endEditing(true)
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.text)
     }

}

extension newRowViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let film = textField.text{
            delegate?.films.append(film)
            delegate?.tableView.reloadData()
        }
        
        return true
    }
}


