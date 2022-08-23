

import UIKit
import SnapKit


class TodoAddView: BaseView {
    
    lazy var textView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .blue
        view.textColor = .white
        view.textContainerInset = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        return view
    }()
    
    let doneButton: UIButton = {
        let view = UIButton()
        view.setTitle("완료", for: .normal)
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        [textView, doneButton].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        textView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(50)
            make.leading.equalTo(self.snp.leading).offset(20)
            make.trailing.equalTo(self.snp.trailing).offset(-20)
            make.height.equalTo(50)
        }
        
        doneButton.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.bottom).offset(20)
            make.trailing.equalTo(self.snp.trailing).offset(-20)
            make.width.height.equalTo(50)
        }
    }
    
}

extension TodoAddView: UITextViewDelegate {
    
}
