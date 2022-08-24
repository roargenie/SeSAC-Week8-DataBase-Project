



import UIKit



class TodoDetailTableViewCell: BaseTableViewCell {
    
    let checkMarkButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        view.tintColor = .white
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .systemFont(ofSize: 14, weight: .bold)
        view.numberOfLines = 1
        return view
    }()
    
    let dateLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .systemFont(ofSize: 10, weight: .bold)
        view.numberOfLines = 1
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, dateLabel])
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fillEqually
        view.spacing = 5
        return view
    }()
    
    let thumbnailImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        [checkMarkButton, stackView, thumbnailImageView].forEach { self.contentView.addSubview($0) }
    }
    
    override func setConstraints() {
        checkMarkButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.leading.equalTo(self.snp.leading).offset(12)
            make.width.height.equalTo(50)
        }
        
        thumbnailImageView.snp.makeConstraints { make in
            make.trailing.equalTo(self.snp.trailing).offset(-12)
            make.width.height.equalTo(80)
            make.centerY.equalTo(checkMarkButton.snp.centerY)
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(checkMarkButton.snp.trailing).offset(12)
            make.centerY.equalTo(checkMarkButton.snp.centerY)
            make.trailing.equalTo(thumbnailImageView.snp.leading).offset(-12)
            make.height.equalTo(60)
        }
    }
    
    
}






