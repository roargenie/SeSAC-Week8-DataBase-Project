

import UIKit
import RealmSwift


class TodoDetailViewController: BaseViewController {
    
    var mainView = TodoDetailView()
    
//    let localRealm = try! Realm()
    
    let repository = ShoppingListRepository()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.textView.delegate = self
        
        setNavigationItem()
    }
    
    // var saveButtonActionHandler: ((TodoList) -> ())?
    
    func setNavigationItem() {
        self.title = "할 일 작성"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(rightBarButtonTapped))
    }
    
    @objc func rightBarButtonTapped() {
       
        guard let text = mainView.textView.text else { return }
        
        let task = TodoList(todoTitle: "", todoContent: text, regDate: Date(), todoDate: Date())
        
        try! repository.localRealm.write {
            repository.localRealm.add(task)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func configure() {
        
    }
    
    override func setConstraints() {
        
    }
    
}

extension TodoDetailViewController: UITextViewDelegate {
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.view.endEditing(true)
    }
}


