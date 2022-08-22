

import UIKit

class BaseViewController: UIViewController {
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configure()
        setConstraints()
    }
    
    func configure() { }
    
    func setConstraints() { }
    
    
}
