

import UIKit


extension UIViewController {
    
    // MARK: - Document에서 이미지 가져와서 보여주기
    // 보여줄 이미지
    func loadImageFromDocument(fileName: String) -> UIImage? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil } // Document 경로
        
        let fileURL = documentDirectory.appendingPathComponent(fileName) // 세부경로. 이미지를 저장할 위치
        
        // 이미지가 없는경우 Default이미지 제공
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)
        } else {
            return nil
        }
        
//        let image = UIImage(contentsOfFile: fileURL.path)
//        return image
    }
    
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
    
    // MARK: - Document에 저장하기
    
    func saveImageToDocument(fileName: String, image: UIImage) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return } // Document 경로
        
        let fileURL = documentDirectory.appendingPathComponent(fileName) // 세부경로. 이미지를 저장할 위치
        
        guard let data = image.jpegData(compressionQuality: 0.5) else { return } // 압축
        
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("file save error", error)
        }
        
    }
    
}
