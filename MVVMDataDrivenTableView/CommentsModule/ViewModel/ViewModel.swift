//
//  ViewModel.swift
//  MVVMDataDrivenTableView
//
//  Created by Dima Khymych on 04.11.2020.
//

import Foundation

protocol ViewModelProtocol {
    
    var viewDataChangeHandler: ((ViewData) -> Void)? {get set}
    func process(_  userAction: UserAction)
    init (networkService: NetworkServiceProtocol, router: SimpleRouterProtocol)
}

final class ViewModel:ViewModelProtocol {
    
    public var viewDataChangeHandler: ((ViewData) -> Void)?
    
    private let networkService: NetworkServiceProtocol
    
    private var comments: [Comment] = []
    
    private let router: SimpleRouterProtocol
    
    init(networkService: NetworkServiceProtocol,
         router: SimpleRouterProtocol) {
        self.networkService = networkService
        self.router = router
        fetchComents()
    }
    
    func process(_ userAction: UserAction) {
        switch userAction {
        case .tap(let index):
            self.showDetail(forItemAtIndex: index)
        }
    }
}

private extension ViewModel {
    
    func fetchComents() {
        networkService.getComments { [weak self] (result) in
            switch result {
            case .success(let comments):
                if let self = self, let comments = comments {
                    self.comments = comments
                    let user = comments.map { User(email: $0.email ?? "😵", name: $0.name ?? "😵") }
                    DispatchQueue.main.async {
                        self.viewDataChangeHandler?(.show(user))
                    }
                }
                // Handle Empty Array
            case .failure(let error):
                // Error Handeler
                print(error.localizedDescription)
            }
        }
    }
    
    func showDetail(forItemAtIndex index: Int){
        let comment = comments[index]
        router.showDetail(with: comment)
    }
}
