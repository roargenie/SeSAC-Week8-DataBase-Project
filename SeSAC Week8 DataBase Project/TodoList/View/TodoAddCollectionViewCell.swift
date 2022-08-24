



import UIKit
import SnapKit
import Kingfisher

class TodoAddCollectionViewCell: BaseCollectionViewCell {
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        [imageView].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    func setImage(data: String) {
        let url = URL(string: data)
        imageView.kf.setImage(with: url)
    }
}

