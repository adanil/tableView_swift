//
//  ContentView.swift
//  TableHW
//
//  Created by Даниил Автушко on 17.03.2021.
//

import SwiftUI

struct sc {
    var ch : Character
    var movies : [String]
}

func createSectionsData() -> [sc]{
    var result : [sc] = []
    for i in 0...27 {
        var ch = Character(UnicodeScalar(i + 65)!)
        var mv = [(String(ch) + "test")]
        result.append(sc(ch:ch,movies:mv))
    }
    return result
}

class sectionViewController : UIViewController{
    public var tableView = UITableView()
    private var editButton : UIButton = {
        let editButton = UIButton()
        editButton.setTitle("Edit", for: .normal)
        editButton.setTitleColor(.systemBlue, for: .normal)
        return editButton
        
    }()
    
    
    private var myRefreshControl : UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    var sections : [sc] = createSectionsData()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        tableView.rowHeight = 50
        tableView.refreshControl = myRefreshControl
        
        editButton.addTarget(self, action: #selector(startEditing), for: .touchUpInside)
        view.addSubview(tableView)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: editButton)
        
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
    
    @objc func refresh(sender: UIRefreshControl){
        tableView.reloadData()
        sender.endRefreshing()
    }
}

extension sectionViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].movies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "filmCell",for: indexPath) as? filmCell
        else{
            return filmCell()
        }
        cell.setTextCell(text: sections[indexPath.section].movies[indexPath.row])
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            sections[indexPath.section].movies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(sections[section].ch)
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        var result: [String] = []
        for i in 0...27{
            result.append(String( Character(UnicodeScalar(i + 65)!)))
        }
        return result
    }
}
