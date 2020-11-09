//
//  ViewData.swift
//  MVVMDataDrivenTableView
//
//  Created by Dima Khymych on 04.11.2020.
//

import Foundation

 enum ViewData {
    case initial
    case show([User])
}

enum UserAction {
    case tap(Int)
}
