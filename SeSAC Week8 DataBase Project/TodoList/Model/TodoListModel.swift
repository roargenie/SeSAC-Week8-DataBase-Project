

import Foundation
import RealmSwift


class TodoList: Object {
    
    @Persisted var todoTitle: String  // 컬렉션뷰에 표시되어야 하기때문에 제목은 필수로
    @Persisted var todoContent: String?  // 내용은 입력하지 않아도 할일 목록 리스트에 등록 될 수 있게
    @Persisted var todoCheck: Bool  // 완료 여부 필수
    @Persisted var favorite: Bool  // 즐겨찾기
    @Persisted var regDate = Date()  // 등록 날짜
    @Persisted var todoDate = Date()  // 작성 날짜
    
    @Persisted(primaryKey: true) var objcetId: ObjectId
    
    convenience init(todoTitle: String, todoContent: String?, regDate: Date, todoDate: Date) {
        self.init()
        self.todoTitle = todoTitle
        self.todoContent = todoContent
        self.regDate = regDate
        self.todoDate = todoDate
        self.todoCheck = false
        self.favorite = false
    }
    
}

class ShoppingList: Object {
    
    @Persisted var title: String
    @Persisted var favorite: Bool
    @Persisted var check: Bool
    @Persisted var date = Date()
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(title: String, date: Date) {
        self.init()
        self.title = title
        self.date = date
        self.favorite = false
        self.check = false
    }
    
}





