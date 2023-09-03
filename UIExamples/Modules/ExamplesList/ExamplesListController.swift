import UIKit
import SwiftUI
import SnapKit

enum Example {
    case niceButton
    case galleryAccess
    
    var title: String {
        switch self {
        case .niceButton: return "Nice Button"
        case .galleryAccess: return "Gallery Access"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .niceButton: return UIImage(systemName: "cursorarrow")
        case .galleryAccess: return UIImage(systemName: "lock.rectangle.on.rectangle.fill")
        }
    }
    
    var background: UIColor {
        switch self {
        case .niceButton: return UIColor(hex: 0x0a84ff)
        case .galleryAccess: return UIColor(hex: 0xea338a)
        }
    }
}

class ExamplesListController: UIViewController {
    
    let examples: [Example] = [
        .niceButton,
        .galleryAccess
    ]
    
    private var mainView: ExamplesListView { view as! ExamplesListView }
    override func loadView() { view = ExamplesListView() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Examples"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        mainView.tableView.reloadData()
    }
    
    private func didSelect(example: Example) {
        switch example {
        case .niceButton:
            let view = NiceButtonExample()
            let vc = UIHostingController(rootView: view)
            present(vc, animated: true)
            
        case .galleryAccess:
            let view = GalleryAccessView()
            let vc = UIHostingController(rootView: view)
            present(vc, animated: true)
        }
    }
}
 
// MARK: - UITableViewDelegate & UITableViewDataSource

extension ExamplesListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelect(example: examples[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return examples.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExampleCell.description(), for: indexPath) as! ExampleCell
        
        let example = examples[indexPath.row]
        cell.titleLabel.text = example.title
        cell.iconImageView.image = example.icon
        cell.gradientLayer.colors = [example.background.cgColor, example.background.offset(by: 0.2).cgColor]
        
        return cell
    }
}

