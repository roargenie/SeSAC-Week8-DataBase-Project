

import UIKit

extension UIViewController {
    
    enum TransitionStyle {
        case present
        case push
    }
    
    func transition<T: UIViewController>(_ viewController: T, transitionStyle: TransitionStyle = .push) {
        switch transitionStyle {
        case .present:
            self.present(viewController, animated: true)
        case .push:
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
    }
    
}









