



import UIKit
import RealmSwift


class TodoSecondDetailViewController: BaseViewController {
    
    var mainView = TodoSecondDetailView()
    
    let repository = ShoppingListRepository()
    
    var tasks: Results<ShoppingList>! {
        didSet {
            mainView.tableView.reloadData()
        }
    }
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tasks = localRealm.objects(ShoppingList.self).sorted(byKeyPath: "favorite", ascending: false)
        setNavigationItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRealm()
        //mainView.tableView.reloadData()
    }
    
    func fetchRealm() {
        tasks = repository.fetch()
    }
    
    func setNavigationItem() {
        let addButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addBarButtonTapped))
        let sortButton = UIBarButtonItem(title: "정렬", style: .plain, target: self, action: #selector(sortButtonTapped))
        
        let check = UIAction(title: "완료된 순으로", image: UIImage(systemName: "heart.fill")) { _ in
            print("클릭되었습니다")
            self.tasks = self.repository.sortItem(style: .check)
            self.mainView.tableView.reloadData()
        }
        let date = UIAction(title: "등록날짜 순으로", image: UIImage(systemName: "calendar")) { _ in
            print("클릭되었습니다")
            self.tasks = self.repository.sortItem(style: .date)
            self.mainView.tableView.reloadData()
        }
        
        let title = UIAction(title: "제목 순으로", image: UIImage(systemName: "pencil")) { _ in
            print("클릭되었습니다")
            self.tasks = self.repository.sortItem(style: .title)
            self.mainView.tableView.reloadData()
        }
        
        sortButton.menu = UIMenu(title: "정렬하기", image: nil, identifier: nil, options: .displayInline, children: [check, date, title])
        
        navigationItem.rightBarButtonItems = [sortButton, addButton]
    }
    
    @objc func sortButtonTapped() {
        
    }
    
    @objc func addBarButtonTapped() {
        let vc = TodoAddViewController()
        transition(vc, transitionStyle: .presentFull)
    }
    
    @objc func checkMarkButtonToggle(_ sender: UIButton) {
        repository.updateCheck(item: tasks[sender.tag])
        //mainView.tableView.reloadData()
//        try! localRealm.write {
//            self.tasks[sender.tag].check = !self.tasks[sender.tag].check
//            self.mainView.tableView.reloadData()
//            //self.mainView.tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
//        }
        
    }
    
    override func configure() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.rowHeight = 100
        self.title = "쇼핑 리스트"
    }
    
    override func setConstraints() {
        
    }
    
}


extension TodoSecondDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoDetailTableViewCell.reuseIdentifier, for: indexPath) as? TodoDetailTableViewCell else { return UITableViewCell() }
        
        let data = tasks[indexPath.row]
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateStyle = .full
        formatter.timeStyle = .medium
        let stringDate = formatter.string(from: data.date)
        
        cell.titleLabel.text = data.title
        cell.dateLabel.text = stringDate
        cell.thumbnailImageView.image = loadImageFromDocument(fileName: "\(tasks[indexPath.row].objectId).jpg")
        cell.backgroundColor = .systemPurple
        
        cell.checkMarkButton.tag = indexPath.row
        cell.checkMarkButton.addTarget(self, action: #selector(checkMarkButtonToggle(_:)), for: .touchUpInside)
        let checkImage = data.check ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "checkmark.square")
        cell.checkMarkButton.setImage(checkImage, for: .normal)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            repository.deleteItem(item: tasks[indexPath.row])
//            tableView.beginUpdates()
//            try! localRealm.write {
//                localRealm.delete(tasks[indexPath.row])
//                tableView.deleteRows(at: [indexPath], with: .fade)
//                tableView.endUpdates()
//            }
//            removeImageFromDocument(fileName: "\(tasks[indexPath.row].objectId).jpg")
        }
    }
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//    }
    
}
