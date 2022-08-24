

import UIKit
import RealmSwift


class TodoAddViewController: BaseViewController {
    
    var mainView = TodoAddView()
    
    let localRealm = try! Realm()
    
    var delegate: SelectImageDelegate?
    var selectImage: UIImage?
    var selectIndex: IndexPath?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
    }
    
    @objc func doneButtonTapped() {
        guard let text = mainView.textView.text else { return }
        //guard let selectImage = selectImage else { return }
        
        //delegate?.sendImageData(image: selectImage)
        let task = ShoppingList(title: text, date: Date())
        
        try! localRealm.write {
            localRealm.add(task)
        }
        if let selectImage = selectImage {
            saveImageToDocument(fileName: "\(task.objectId).jpg", image: selectImage)
        }
        
        self.dismiss(animated: true)
        
    }
    
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true)
    }
    
    override func configure() {
        mainView.doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        mainView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    
    override func setConstraints() {
        
    }
    
}

extension TodoAddViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImageDummy.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodoAddCollectionViewCell.reuseIdentifier, for: indexPath) as? TodoAddCollectionViewCell else { return UICollectionViewCell() }
        cell.setImage(data: ImageDummy.data[indexPath.item].url)
        cell.layer.borderWidth = selectIndex == indexPath ? 3 : 0
        cell.layer.borderColor = selectIndex == indexPath ? UIColor.systemOrange.cgColor : nil
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? TodoAddCollectionViewCell else { return }
        
        selectImage = cell.imageView.image
        selectIndex = indexPath
        collectionView.reloadData()
    }
    
    
}
