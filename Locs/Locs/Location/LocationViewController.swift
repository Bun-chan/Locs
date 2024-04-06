//
//  ViewController.swift
//  Locs
//
//  Created by STEPHEN FITZGERALD on 2024/04/06.
//

import UIKit

class LocationViewController: UIViewController {

    private var viewModel: LocationViewModel
    
    init(viewModel: LocationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .white

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func addLocation(_ sender: Any) {
        
    }
    
    private func bindings() {
//        viewModel.getCurrentLocation
    }
    
}

