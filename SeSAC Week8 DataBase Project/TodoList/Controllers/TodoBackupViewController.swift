



import UIKit
import Zip

class TodoBackupViewController: BaseViewController {
    
    var mainView = TodoBackupView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.restoreButtonTapped()
        }
    }
    
    @objc func backupButtonTapped() {
        
        var urlPaths = [URL]()
        
        // 도큐먼트 위치에 백업 파일이 존재하는지 확인
        guard let path = documentDirectoryPath() else {
            showAlertMessage(title: "도큐먼트 위치에 오류가 있습니다", button: "확인")
            return
        }
        
        let realmFile = path.appendingPathComponent("default.realm")
        
        guard FileManager.default.fileExists(atPath: realmFile.path) else {
            showAlertMessage(title: "백업할 파일이 없습니다", button: "확인")
            return
        }
        
        urlPaths.append(URL(string: realmFile.path)!)
        
        // 백업 파일을 압축: URL
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "SeSACDiary_1")
            print("Archive Location: \(zipFilePath)")
            // 성공했을시 액티비티 컨트롤러 띄우기
            showActivityViewController()
        } catch {
            showAlertMessage(title: "압축을 실패했습니다", button: "확인")
        }
        
    }
    
    // ActivityViewController
    func showActivityViewController() {
        
        guard let path = documentDirectoryPath() else {
            showAlertMessage(title: "도큐먼트 위치에 오류가 있습니다", button: "확인")
            return
        }
        
        let backupFileURL = path.appendingPathComponent("SeSACDiary_1.zip")
        
        let vc = UIActivityViewController(activityItems: [backupFileURL], applicationActivities: [])
        self.present(vc, animated: true)
    }
    
    func restoreButtonTapped() {
        
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy: true)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        self.present(documentPicker, animated: true)
    }
    
    override func configure() {
        mainView.backupButton.addTarget(self, action: #selector(backupButtonTapped), for: .touchUpInside)
    }
    
    override func setConstraints() {
        
    }
    
}


extension TodoBackupViewController: UIDocumentPickerDelegate {
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function, "데이터를 불러오지 않았습니다.")
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        // 멀티플 셀렉션을 false로 설정해뒀기 때문에 항상 배열의 첫번째 것으로 확인하면 됨
        guard let selectedFileURL = urls.first else {
            showAlertMessage(title: "선택한 파일을 찾을 수 없습니다.", button: "확인")
            return
        }
        
        // 앱 도큐먼트로 파일을 가져와야 하기 때문에 경로를 확인해서 가져오기
        guard let path = documentDirectoryPath() else {
            showAlertMessage(title: "도큐먼트 위치에 오류가 있습니다", button: "확인")
            return
        }
        
        // 파일 이름을 모르기 때문에 앱 도큐먼트 경로.lastPathComponent로 이름+확장자를 가져오기
        let sandboxFileURL = path.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            
            let fileURL = path.appendingPathComponent("SeSACDiary_1.zip")  // sandboxFileURL을 사용해도 상관없음. 어차피 같기때문에
            
            // 압축을 풀어서 어디에 넣을지 설정
            do {
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                    self.showAlertMessage(title: "복구가 완료되었습니다.", button: "확인")
                })
                
            } catch {
                showAlertMessage(title: "압축 해제에 실패했습니다.", button: "확인")
            }
            
        } else {
            
            do {
                // 파일 앱의 zip -> 앱 도큐먼트 폴더에 복사
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                
                let fileURL = path.appendingPathComponent("SeSACDiary_1.zip")
                
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                    self.showAlertMessage(title: "복구가 완료되었습니다.", button: "확인")
                })
                
            } catch {
                showAlertMessage(title: "압축 해제에 실패했습니다.", button: "확인")
            }
        }
        
    }
    
}
