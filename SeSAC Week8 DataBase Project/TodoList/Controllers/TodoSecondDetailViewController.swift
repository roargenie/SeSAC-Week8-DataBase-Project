



import UIKit
import RealmSwift


class TodoSecondDetailViewController: BaseViewController {
    
    var mainView = TodoSecondDetailView()
    
    let localRealm = try! Realm()
    
    var tasks: Results<ShoppingList>!
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.rowHeight = 50
        
        tasks = localRealm.objects(ShoppingList.self).sorted(byKeyPath: "favorite", ascending: false)
        self.title = "쇼핑 리스트"
        
        setNavigationItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.tableView.reloadData()
    }
    
    func setNavigationItem() {
        let addButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addBarButtonTapped))
        let sortButton = UIBarButtonItem(title: "정렬", style: .plain, target: self, action: #selector(sortButtonTapped))
        
        let check = UIAction(title: "완료된 순으로", image: UIImage(systemName: "heart.fill")) { _ in
            print("클릭되었습니다")
            self.tasks = self.localRealm.objects(ShoppingList.self).sorted(byKeyPath: "check", ascending: true)
            self.mainView.tableView.reloadData()
        }
        let date = UIAction(title: "등록날짜 순으로", image: UIImage(systemName: "calendar")) { _ in
            print("클릭되었습니다")
        }
        
        let title = UIAction(title: "제목 순으로", image: UIImage(systemName: "pencil")) { _ in
            print("클릭되었습니다")
            self.tasks = self.localRealm.objects(ShoppingList.self).sorted(byKeyPath: "title", ascending: true)
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
        try! localRealm.write {
            self.tasks[sender.tag].check = !self.tasks[sender.tag].check
            self.mainView.tableView.reloadData()
            //self.mainView.tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
        }
       
    }
    
    override func configure() {
        
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
        cell.titleLabel.text = data.title
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
            tableView.beginUpdates()
            try! localRealm.write {
                localRealm.delete(tasks[indexPath.row])
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
            }
        }
    }
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//    }
    
    
    
}
