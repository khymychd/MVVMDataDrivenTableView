//
//  DetailViewModel.swift
//  MVVMDataDrivenTableView
//
//  Created by Dima Khymych on 07.11.2020.
//

import Foundation

protocol DetailViewModelProtocol {
    func back()
    func showText() -> String
}

class DetailViewModel:DetailViewModelProtocol {

    let router:SimpleRouterProtocol
    private var comment:Comment
    
    required init(router:SimpleRouterProtocol, comment:Comment) {
        self.router = router
        self.comment = comment
        
        
    }
    
    
    func showText() -> String {
       return comment.body!
    }
    
    
    func back() {
        router.back()
    }
    
}
