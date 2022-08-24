

import UIKit
import RealmSwift  // import


class TodoMainViewController: BaseViewController {
    
    var mainView = TodoMainView()
    
    let localRealm = try! Realm()  // 경로 가져옴
    
    var tasks: Results<TodoList>!  // 저장할 공간 만들기
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasks = localRealm.objects(TodoList.self).sorted(byKeyPath: "todoContent", ascending: false)
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        setNavigationItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.collectionView.reloadData()
    }
    
    func setNavigationItem() {
        self.title = "나의 할 일"
        let plusBarButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(rightPlusBarButtonTapped))
        let listBarButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(rightListBarButtonTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "백업", style: .plain, target: self, action: #selector(backupBarButtonTapped))
        navigationItem.rightBarButtonItems = [plusBarButton, listBarButton]
    }
    
    @objc func backupBarButtonTapped() {
        let vc = TodoBackupViewController()
        transition(vc, transitionStyle: .push)
    }
    
    @objc func rightPlusBarButtonTapped() {
        let vc = TodoDetailViewController()
        transition(vc, transitionStyle: .push)
    }
    
    @objc func rightListBarButtonTapped() {
        let vc = TodoSecondDetailViewController()
        transition(vc, transitionStyle: .push)
    }
    
    @objc func checkButtonTapped(sender: UIButton) {
        try! localRealm.write {
            self.tasks[sender.tag].todoCheck = !self.tasks[sender.tag].todoCheck
            mainView.collectionView.reloadItems(at: [IndexPath(item: sender.tag, section: 0)])
        }
    }
    
    override func configure() {
        
    }
        
    override func setConstraints() {
        
    }
}

extension TodoMainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodoMainCollectionViewCell.reuseIdentifier, for: indexPath) as? TodoMainCollectionViewCell else { return UICollectionViewCell() }
        cell.backgroundColor = .lightGray
        cell.checkButton.tag = indexPath.item
        cell.checkButton.addTarget(self, action: #selector(checkButtonTapped(sender:)), for: .touchUpInside)
        
        let data = tasks[indexPath.item]
        
        let value = data.todoCheck ? "checkmark.square.fill" : "checkmark.square"
        cell.checkButton.setImage(UIImage(systemName: value), for: .normal)
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 MM월 dd일"
        let stringDate = formatter.string(from: data.todoDate)
        cell.dateLabel.text = stringDate
        cell.preViewLabel.text = data.todoContent
        
        return cell
    }
    
}











