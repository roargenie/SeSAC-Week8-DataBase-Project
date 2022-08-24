



import UIKit


class TodoBackupViewController: BaseViewController {
    
    var mainView = TodoBackupView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

