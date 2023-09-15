import UIKit
import SwiftUI
import SnapKit

class ExamplesListController: UIViewController {
    
    typealias Model = ExampleListModel
    
    enum Section: Int, CaseIterable {
        case swiftUI = 0
        
        init(at indexPath: IndexPath) {
            self.init(rawValue: indexPath.section)!
        }
        
        init(_ section: Int) {
            self.init(rawValue: section)!
        }
        
        var title: String {
            switch self {
            case .swiftUI: return "SwiftUI"
            }
        }
    }
    
    private let model = Model.initial
    
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
    
    private func handleSwiftUITap(at indexPath: IndexPath) {
        let view = model.swiftUIExamples[indexPath.row].view
        let vc = UIHostingController(rootView: view)
        
        present(vc, animated: true)
    }
    
    // maybe give model to cell for configure
    private func configureSwiftUICell(_ cell: ExampleCell, at indexPath: IndexPath) {
        let example = model.swiftUIExamples[indexPath.row]
        
        cell.titleLabel.text = example.title
        cell.iconImageView.image = UIImage(systemName: example.sfSymbol)
        cell.gradientLayer.colors = [example.background.cgColor, example.background.offset(by: 0.2).cgColor]
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension ExamplesListController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch Section(at: indexPath) {
        case .swiftUI: handleSwiftUITap(at: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(section) {
        case .swiftUI:
            return model.swiftUIExamples.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Section(at: indexPath) {
        case .swiftUI:
            let cell = tableView.dequeueReusableCell(withIdentifier: ExampleCell.description(), for: indexPath) as! ExampleCell
            configureSwiftUICell(cell, at: indexPath)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { action, view, completion in
            
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
