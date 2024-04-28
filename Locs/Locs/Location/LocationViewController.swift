import UIKit
import Combine

class LocationViewController: UIViewController {

    private var viewModel: LocationViewModel
    private var cancellables: Set<AnyCancellable> = []
    private let fontSize = 28.0

    init(viewModel: LocationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .white
        setupUI()
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @objc
    func addCurrentLocation() {
        viewModel.addCurrentLocation()
    }
    
    private func setupBindings() {
        viewModel.locationAdded
            .sink { [weak self] value in
                if value {
                    self?.showSuccess()
                } else {
                    //show error
                }
            }
            .store(in: &cancellables)
    }
    
    private func showSuccess() {
        let successView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        view.addSubview(successView)
        let successLabel = UILabel()
        successView.addSubview(successLabel)
        successLabel.font = .systemFont(ofSize: fontSize)
        successLabel.translatesAutoresizingMaskIntoConstraints = false
        successView.translatesAutoresizingMaskIntoConstraints = false
        successLabel.text = "successfully added a location"
        successView.layer.backgroundColor = UIColor.brown.cgColor
        successView.layer.cornerRadius = 10.0
        let margin = 22.0
        NSLayoutConstraint.activate([
            successView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            successView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            successView.heightAnchor.constraint(equalToConstant: 55.0),
            successView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            successView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            successLabel.centerXAnchor.constraint(equalTo: successView.centerXAnchor),
            successLabel.centerYAnchor.constraint(equalTo: successView.centerYAnchor)
        ])
        UIView.animate(withDuration: 1.5, delay: 1.0, options: []) {
            successView.layer.opacity = 0
        } completion: { _ in
            successView.removeFromSuperview()
        }
    }
    
    private func setupUI() {
        //Add the 'add location' button
        let addLocation = UIButton()
        view.addSubview(addLocation)
        addLocation.titleLabel?.font = .systemFont(ofSize: fontSize)
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

