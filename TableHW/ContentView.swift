//
//  ContentView.swift
//  TableHW
//
//  Created by Даниил Автушко on 17.03.2021.
//

import SwiftUI

class myViewController : UIViewController{
    let tabBarVC = UITabBarController()
    public var tableView = UITableView()
    private var editButton : UIButton = {
        let editButton = UIButton()
        editButton.setTitle("Edit", for: .normal)
        editButton.setTitleColor(.systemBlue, for: .normal)
        return editButton
        
    }()
    
    private var addButton : UIButton = {
        let addButton = UIButton()
        addButton.setTitle("+", for: .normal)
        addButton.setTitleColor(.systemBlue, for: .normal)
        return addButton
        
    }()
    
    private var myRefreshControl : UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    var films = ["Iron man","Spiderman","Batman"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        
        tableView.rowHeight = 50
        tableView.refreshControl = myRefreshControl
        
        editButton.addTarget(self, action: #selector(startEditing), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addRecord), for: .touchUpInside)
        view.addSubview(tableView)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: editButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
        
        tableView.register(filmCell.self,forCellReuseIdentifier: "filmCell")
        tableView.delegate = self
        tableView.dataSource = self
        layoutConstraints()
        
    }
    
    private func layoutConstraints(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    @objc func startEditing(){
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    @objc func addRecord(){
        let newViewController = newRowViewController()
        newViewController.delegate = self
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @objc func refresh(sender: UIRefreshControl){
        films.append("New item 1")
        films.append("New item 2")
        films.append("New item 3")
        tableView.reloadData()
        sender.endRefreshing()
    }
}

extension myViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "filmCell",for: indexPath) as? filmCell
        else{
            return filmCell()
        }
        cell.setTextCell(text: films[indexPath.row])
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            films.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
