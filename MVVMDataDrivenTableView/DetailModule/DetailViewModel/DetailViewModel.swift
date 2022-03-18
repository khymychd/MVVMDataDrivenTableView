//
//  DetailViewModel.swift
//  MVVMDataDrivenTableView
//
//  Created by Dima Khymych on 07.11.2020.
//

import Foundation

protocol DetailViewModelProtocol {
    var text: String { get}
    func back()
}

class DetailViewModel: DetailViewModelProtocol {

    let text: String
    private let router: SimpleRouterProtocol
    
    init(router: SimpleRouterProtocol, comment: Comment) {
        self.router = router
        self.text = comment.body ?? "Empty text placeholder"
    }

    func back() {
        router.back()
    }
}
