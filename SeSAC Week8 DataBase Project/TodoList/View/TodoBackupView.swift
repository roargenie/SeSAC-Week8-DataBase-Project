

import UIKit
import SnapKit



class TodoBackupView: BaseView {
    
    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.backgroundColor = .systemOrange
        view.register(TodoBackupTableViewCell.self, forCellReuseIdentifier: TodoBackupTableViewCell.reuseIdentifier)
        return view
    }()
    
    let backupButton: UIButton = {
        let view = UIButton()
        view.setTitle("백업", for: .normal)
        view.backgroundColor = .systemMint
        return view
    }()
    
    let migrationButton: UIButton = {
        let view = UIButton()
        view.setTitle("복구", for: .normal)
        view.backgroundColor = .systemPurple
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [backupButton, migrationButton])
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fillEqually
        view.spacing = 10
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        [tableView, stackView].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(self.snp.leading).offset(20)
            make.trailing.equalTo(self.snp.trailing).offset(-20)
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
    
}
