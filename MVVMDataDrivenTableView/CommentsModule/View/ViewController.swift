//
//  ViewController.swift
//  MVVMDataDrivenTableView
//
//  Created by Dima Khymych on 04.11.2020.
//

import UIKit

class ViewController: UIViewController {

    var viewModel:ViewModelProtocol!
    var presentView:PresentableView!

    fileprivate func initialize() {
        let networkService = NetworkService()
        let router = SimplePouter(navigationController: navigationController!)
        viewModel = ViewModel(networkService: networkService, router: router)
        presentView = PresentableView()
    }
    
      
       
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        presentView.frame = self.view.frame
        viewModel.updateViewData = {[unowned self] viewData in self.presentView.viewData = viewData}
        presentView.userAction = {[unowned self] userAction in self.viewModel.userAction = userAction}
        self.view.addSubview(presentView)
        
    }


    
    

}

