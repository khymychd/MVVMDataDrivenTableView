//
//  ViewController.swift
//  MVVMDataDrivenTableView
//
//  Created by Dima Khymych on 04.11.2020.
//

import UIKit

class CommentsViewController: UIViewController {

    var viewModel: ViewModelProtocol!
    var presentView: PresentableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        presentView.frame = view.frame
        viewModel.viewDataChangeHandler = { [weak self] viewData in
            guard let self = self else { return }
            self.presentView.viewData = viewData
        }
        presentView.userActionHandler = { [weak self] action in
            guard let self = self else { return }
            self.viewModel.process(action)
        }
        view.addSubview(presentView)
    }
}

private extension CommentsViewController {
    
    func initialize() {
        let networkService = NetworkService()
        let router = SimplePouter(navigationController: navigationController!)
        viewModel = ViewModel(networkService: networkService, router: router)
        presentView = PresentableView()
    }
}
