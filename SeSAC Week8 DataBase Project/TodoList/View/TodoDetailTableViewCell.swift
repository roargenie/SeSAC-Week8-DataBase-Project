



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
        view.font = .systemFont(ofSize: 12, weight: .bold)
        //view.backgroundColor = .systemGray5
        view.numberOfLines = 1
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        [checkMarkButton, titleLabel].forEach { self.contentView.addSubview($0) }
    }
    
    override func setConstraints() {
        checkMarkButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.leading.equalTo(self.snp.leading).offset(12)
            make.width.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(checkMarkButton.snp.centerY)
            make.leading.equalTo(checkMarkButton.snp.trailing).offset(12)
            make.trailing.lessThanOrEqualTo(self.snp.trailing).offset(-12)
        }
    }
    
    
}






