

import UIKit
import SnapKit


class TodoAddView: BaseView {
    
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: mainCollectionViewLayout())
        view.backgroundColor = .systemPurple
        view.register(TodoAddCollectionViewCell.self, forCellWithReuseIdentifier: TodoAddCollectionViewCell.reuseIdentifier)
        return view
    }()
    
    lazy var textView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .blue
        view.textColor = .white
        view.textContainerInset = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        return view
    }()
    
    let doneButton: UIButton = {
        let view = UIButton()
        view.setTitle("저장", for: .normal)
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 12
        return view
    }()
    
    let cancelButton: UIButton = {
        let view = UIButton()
        view.setTitle("취소", for: .normal)
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
        [textView, doneButton, cancelButton, collectionView].forEach { self.addSubview($0) }
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
            make.width.height.equalTo(40)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.bottom).offset(20)
            make.leading.equalTo(self.snp.leading).offset(20)
            make.width.height.equalTo(40)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.bottom).offset(80)
            make.leading.equalTo(self.safeAreaLayoutGuide)
            make.trailing.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    static func mainCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let deviceWidth: CGFloat = UIScreen.main.bounds.width
        let itemSize: CGFloat = deviceWidth / 2
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.scrollDirection = .vertical
        return layout
    }
    
}

extension TodoAddView: UITextViewDelegate {
    
}
