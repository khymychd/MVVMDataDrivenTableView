//
//  Router.swift
//  MVVMDataDrivenTableView
//
//  Created by Dima Khymych on 07.11.2020.
//

import UIKit

protocol SimpleRouterProtocol {
    func showDetail(with comment:Comment)
    func back()
}

class SimplePouter:SimpleRouterProtocol {

    var navigationController:UINavigationController
    
    init(navigationController:UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showDetail(with comment: Comment) {
        let detail = DetailViewController()
        detail.viewModel = DetailViewModel(router: self, comment: comment)
        navigationController.pushViewController(detail, animated: true)
    }
    
    func back() {
        navigationController.popToRootViewController(animated: true)
    }
}
