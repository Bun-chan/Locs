//
//  ViewController.swift
//  Locs
//
//  Created by STEPHEN FITZGERALD on 2024/04/06.
//

import UIKit
import Combine

class LocationViewController: UIViewController {

    private var viewModel: LocationViewModel
    private var cancellables: Set<AnyCancellable> = []

    
    init(viewModel: LocationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .white
        bindings()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @objc
    func addCurrentLocation() {
        viewModel.addLocationTapped.send(())
    }
    
    private func bindings() {
        //When addLocation button is tapped get the current location.
        viewModel.addLocationTapped
            .sink(receiveValue: { [weak self] in
                self?.viewModel.addCurrentLocation()
            })
            .store(in: &cancellables)
    }
    
    private func setupUI() {
        //Add the 'add location' button
        let addLocation = UIButton()
        view.addSubview(addLocation)
        addLocation.translatesAutoresizingMaskIntoConstraints = false
        addLocation.layer.cornerRadius = 15.0
        addLocation.backgroundColor = .brown
        addLocation.setTitle("add location", for: .normal)
        addLocation.addTarget(self, action: #selector(addCurrentLocation), for: .touchUpInside)
        NSLayoutConstraint.activate([
            addLocation.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addLocation.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -55.0),
            addLocation.widthAnchor.constraint(equalToConstant: 200.0),
            addLocation.heightAnchor.constraint(equalToConstant: 63.0)
        ])
    }
    
}

