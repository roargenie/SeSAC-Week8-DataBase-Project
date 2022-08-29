


import Foundation
import RealmSwift

enum SortList {
    case title
    case check
    case date
}

protocol ShoppingListRepositoryType {
    func fetch() -> Results<ShoppingList>
    func fetchFilter() -> Results<ShoppingList>
    func fetchDate(date: Date) -> Results<ShoppingList>
    func sortItem(style: SortList) -> Results<ShoppingList>
    func addItem(item: ShoppingList)
    func deleteItem(item: ShoppingList)
    func updateCheck(item: ShoppingList)
}


class ShoppingListRepository: ShoppingListRepositoryType {
    
    let localRealm = try! Realm()
    
    func fetch() -> Results<ShoppingList> {
        return localRealm.objects(ShoppingList.self).sorted(byKeyPath: "title", ascending: true)
    }
    
    func fetchFilter() -> Results<ShoppingList> {
        return localRealm.objects(ShoppingList.self).filter("title CONTAINS[c] 'ㄱ'")
    }
    
    func fetchDate(date: Date) -> Results<ShoppingList> {
        return localRealm.objects(ShoppingList.self).filter("date >= %@ AND date < %@", date, Date(timeInterval: 86400, since: date))
    }
    
    func addItem(item: ShoppingList) {
        do {
            try localRealm.write {
                localRealm.add(item)
            }
        } catch {
            print("error")
        }
    }
    
    func updateCheck(item: ShoppingList) {
        do {
            try localRealm.write {
                item.check = !item.check
                
            }
        } catch {
            print("error")
        }
        
    }
    
    func deleteItem(item: ShoppingList) {
        do {
            removeImageFromDocument(fileName: "\(item.objectId).jpg")
            try localRealm.write {
                localRealm.delete(item)
            }
            
        } catch {
            print("error")
        }
    }
    
    func sortItem(style: SortList) -> Results<ShoppingList> {
        switch style {
        case .title:
            return localRealm.objects(ShoppingList.self).sorted(byKeyPath: "title", ascending: true)
        case .check:
            return localRealm.objects(ShoppingList.self).sorted(byKeyPath: "check", ascending: true)
        case .date:
            return localRealm.objects(ShoppingList.self).sorted(byKeyPath: "date", ascending: true)
        }
    }
    
}

extension ShoppingListRepository {
    
    // MARK: - Document에서 삭제하기
    
    func removeImageFromDocument(fileName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch let error {
            print(error)
        }
    }
    
}







