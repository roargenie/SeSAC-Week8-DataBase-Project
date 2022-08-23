

import UIKit
import RealmSwift


class TodoAddViewController: BaseViewController {
    
    var mainView = TodoAddView()
    
    let localRealm = try! Realm()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
    }
    
    @objc func doneButtonTapped() {
        
        guard let text = mainView.textView.text else { return }
        
        let task = ShoppingList(title: text)
        
        try! localRealm.write {
            localRealm.add(task)
            self.dismiss(animated: true)
        }
        
    }
    
    override func configure() {
        
    }
    
    override func setConstraints() {
        
    }
    
}
