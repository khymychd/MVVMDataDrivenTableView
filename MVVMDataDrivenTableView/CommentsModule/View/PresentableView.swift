//
//  PresentableView.swift
//  MVVMDataDrivenTableView
//
//  Created by Dima Khymych on 04.11.2020.
//

import UIKit

final class PresentableView:UIView {
    
    var viewData:ViewData = .initial {
        didSet{
            update()
        }
    }
    
    var userAction:((UserAction) -> Void)?
    
    lazy var tableView = self.makeTableView()
    
    var users:[User]?
    
    var router:SimpleRouterProtocol!
    
    func update() {
        switch viewData {
        case .show(let user):
            self.users = user
            tableView.reloadData()
        case .initial:
            break
        }
    }
}


extension PresentableView {
    
    var identifier:String {
        return "Cell"
    }
    
    func makeTableView () -> UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }
   
}


extension PresentableView:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as UITableViewCell
        cell.textLabel?.text = users?[indexPath.row].email
        return cell
    }
    
    
}

extension PresentableView:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userAction?(.tap(indexPath.item))
    }
}

