import UIKit

class ExampleCell: UITableViewCell {

    let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.layer.cornerCurve = .continuous
        view.clipsToBounds = true
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Example"
        label.textColor = .white
        label.font = .systemFont(ofSize: 23, weight: .semibold)
        
        return label
    }()
    
    let blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        
        return view
    }()
    
    let iconContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.cornerCurve = .continuous
        view.layer.borderColor = UIColor(white: 1, alpha: 0.8).cgColor
        view.layer.borderWidth = 1.5
        view.clipsToBounds = true
        
        return view
    }()
    
    let iconImageView: UIImageView = {
        let view = UIImageView()
        view.tintColor = .white
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    var isGradientSetted: Bool = false
    
    let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 1)
        
        return layer
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        backgroundColor = .clear
        contentView.addSubview(containerView)
        
        containerView.addSubview(iconContainerView)
        containerView.addSubview(titleLabel)
        containerView.layer.insertSublayer(gradientLayer, at: 0)
        
        iconContainerView.addSubview(blurView)
        iconContainerView.addSubview(iconImageView)
        
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !isGradientSetted && containerView.bounds != .zero {
            gradientLayer.frame = containerView.bounds
            isGradientSetted = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16.0)
            make.top.bottom.equalToSuperview().inset(10.0)
        }
        
        iconContainerView.snp.makeConstraints { make in
            make.top.bottom.left.equalToSuperview().inset(20.0)
            make.size.equalTo(42.0)
        }
        
        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(6.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(iconContainerView.snp.right).offset(12.0)
            make.centerY.equalToSuperview()
        }
    }
    
}
