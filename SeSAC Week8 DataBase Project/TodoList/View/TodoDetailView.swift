

import UIKit
import SnapKit

class TodoDetailView: BaseView {
    
    let textView: UITextView = {
        let view = UITextView()
        view.font = .systemFont(ofSize: 12, weight: .black)
        view.backgroundColor = .systemMint
        view.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        [textView].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        textView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}









