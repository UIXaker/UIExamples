import UIKit

class ExampleCell: UITableViewCell {

    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = getRandomColor()
        view.layer.cornerRadius = 20
        view.layer.cornerCurve = .continuous
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Example"
        
        return label
    }()
    
    let iconImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = getRandomColor()
        view.layer.cornerRadius = 10
        view.layer.cornerCurve = .continuous
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        backgroundColor = .clear
        contentView.addSubview(containerView)
        
        containerView.addSubview(iconImageView)
        containerView.addSubview(titleLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20.0)
            make.top.bottom.equalToSuperview().inset(10.0)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.top.bottom.left.equalToSuperview().inset(20.0)
            make.size.equalTo(36.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.right).offset(12.0)
            make.centerY.equalToSuperview()
        }
    }
    
}

func getRandomColor() -> UIColor {
    let red = CGFloat.random(in: 0.0...1.0)
    let green = CGFloat.random(in: 0.0...1.0)
    let blue = CGFloat.random(in: 0.0...1.0)
    return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
}
