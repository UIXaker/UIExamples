import UIKit
import SnapKit

class ViewController: UIViewController {

    lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(ExampleCell.self, forCellReuseIdentifier: ExampleCell.description())
        view.backgroundColor = .clear
        view.estimatedRowHeight = UITableView.automaticDimension
        view.dataSource = self
        view.delegate = self
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Examples"
        
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
 
// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExampleCell.description(), for: indexPath) as! ExampleCell
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

