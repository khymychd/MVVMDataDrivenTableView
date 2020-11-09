//
//  ViewModel.swift
//  MVVMDataDrivenTableView
//
//  Created by Dima Khymych on 04.11.2020.
//

import Foundation

protocol ViewModelProtocol {
    var updateViewData:((ViewData) -> Void)? {get set}
    
    var userAction:UserAction! {get set}

    init (networkService:NetworkServiceProtocol, router:SimpleRouterProtocol)
}


final class ViewModel:ViewModelProtocol {
   
    public var userAction: UserAction!{didSet{actionRun()}}

    public var updateViewData: ((ViewData) -> Void)?
    
    private let networkService:NetworkServiceProtocol
    
    private var comments:[Comment]?
    
    private let router:SimpleRouterProtocol
    
    init(networkService:NetworkServiceProtocol,router:SimpleRouterProtocol) {
        self.networkService = networkService
        self.router = router
        request()
    }

    func request() {
        networkService.getComments {[unowned self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let comments):
                    if let comments = comments {
                        self.comments = comments
                        let user = comments.map({User(email: $0.email!, name: $0.name!)})
                        self.updateViewData?(.show(user))
                    }
                case .failure(let error):
                    //Error Handeler
                    print(error.localizedDescription)
                }
            }
        }
    }
       
    func actionRun() {
        switch userAction {
        case .tap(let index):
            self.tap(at: index)
        case .none:
            break
        }
    
    }
    
    func tap(at item:Int){
        guard let comment = comments?[item] else{return}
        router.showDetail(with: comment)
    }
    
    
    
}
