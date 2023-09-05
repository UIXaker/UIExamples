import UIKit

class PrivacyViewController: UIViewController {

    private var mainView: PrivacyUIKitView { view as! PrivacyUIKitView }
    override func loadView() { view = PrivacyUIKitView() }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.titleView = NavPriView()
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar
    }

}

class NavPriView: UIView {
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "lock.fill")
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Apple Privacy"
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        addSubview(titleLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12.0)
            make.size.equalTo(50)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20.0)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-12.0)
        }
    }
    
}
