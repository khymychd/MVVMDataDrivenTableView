//
//  DetailViewController.swift
//  MVVMDataDrivenTableView
//
//  Created by Dima Khymych on 07.11.2020.
//

import UIKit

class DetailViewController: UIViewController {

    var viewModel: DetailViewModelProtocol!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailLabel.text = viewModel.text
    }

    @IBAction func backButtonDidPress(_ sender: Any) {
        viewModel.back()
    }
}
