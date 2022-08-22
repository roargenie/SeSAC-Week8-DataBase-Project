

import UIKit
import SnapKit


class TodoMainView: BaseView {
    
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: mainCollectionViewLayout())
        view.backgroundColor = .blue
        view.register(TodoMainCollectionViewCell.self, forCellWithReuseIdentifier: TodoMainCollectionViewCell.reuseIdentifier)
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        [collectionView].forEach { self.addSubview($0) }
        
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    static func mainCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let deviceWidth: CGFloat = UIScreen.main.bounds.width
        let itemSize: CGFloat = (deviceWidth - 10) / 2
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.scrollDirection = .vertical
        return layout
    }
    
    
}







