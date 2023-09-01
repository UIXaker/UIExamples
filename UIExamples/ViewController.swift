import UIKit
import SwiftUI
import SnapKit

enum Example {
    case niceButton
    
    var title: String {
        switch self {
        case .niceButton: return "Nice Button"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .niceButton: return UIImage(systemName: "cursorarrow")
        }
    }
    
    var background: UIColor {
        switch self {
        case .niceButton: return .blue
        }
    }
}

class ViewController: UIViewController {

    let tableView: UITableView = {
        let view = UITableView()
        view.register(ExampleCell.self, forCellReuseIdentifier: ExampleCell.description())
        view.backgroundColor = .clear
//        view.estimatedRowHeight = UITableView.automaticDimension
        
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        
        return view
    }()
    
    let examples: [Example] = [
        .niceButton
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Examples"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.reloadData()
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func didSelect(example: Example) {
        switch example {
        case .niceButton:
            let view = NiceButtonExample()
            let vc = UIHostingController(rootView: view)
            vc.title = example.title
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
 
// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return examples.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExampleCell.description(), for: indexPath) as! ExampleCell
        
        let example = examples[indexPath.row]
        cell.titleLabel.text = example.title
        cell.iconImageView.image = example.icon
        cell.gradientLayer.colors = [example.background.offset(by: 0.2).cgColor, example.background.cgColor]
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelect(example: examples[indexPath.row])
    }
}


