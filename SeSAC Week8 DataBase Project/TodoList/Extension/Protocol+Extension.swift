



import UIKit


protocol ReusableViewProtocol: AnyObject {
    static var reuseIdentifier: String { get }
}

protocol SelectImageDelegate {
    func sendImageData(image: UIImage)
}

extension UIViewController: ReusableViewProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableViewProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableViewProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
