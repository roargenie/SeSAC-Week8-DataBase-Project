

import UIKit


class TodoMainCollectionViewCell: BaseCollectionViewCell {
    
    let checkButton: UIButton = {
        let view = UIButton()
        //view.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        return view
    }()
    
    let dateLabel: UILabel = {
        let view = UILabel()
        //view.text = "2022-08-22"
        view.font = .systemFont(ofSize: 10, weight: .black)
        return view
    }()
    
    let preViewLabel: UILabel = {
        let view = UILabel()
        view.text = "aaaasdfasdfasdfasdfsafasdfasfsadfasdfsafdadfasdf"
        view.font = .systemFont(ofSize: 12, weight: .black)
        view.numberOfLines = 0
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        [checkButton, dateLabel, preViewLabel].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        checkButton.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.leading.equalTo(self.snp.leading).offset(10)
            //make.width.height.equalTo(50)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(checkButton.snp.centerY)
            make.leading.equalTo(checkButton.snp.trailing).offset(12)
            make.trailing.lessThanOrEqualTo(self.snp.trailing).offset(-10)
            make.height.equalTo(25)
        }
        
        preViewLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(12)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
    
    
}





