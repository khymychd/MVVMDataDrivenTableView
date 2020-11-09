//
//  ConfigurationType.swift
//  MVVMDataDrivenTableView
//
//  Created by Dima Khymych on 04.11.2020.
//

import UIKit

protocol ConfiguratorType {
    associatedtype Item
    associatedtype Cell: UITableViewCell
    
    func reuseIdentifier(for item: Item, indexPath: IndexPath) -> String
    func configuredCell(for item: Item, tableView: UITableView, indexPath: IndexPath) -> Cell
    func registerCells(in tableView: UITableView)
}
