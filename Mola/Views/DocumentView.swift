//
//  DocumentView.swift
//  Mola
//
//  Created by 김민창 on 2021/05/27.
//

import SwiftUI

class DocumentView: UIViewController {
    var document: Document?
    
    private let titleLabel = UILabel().then() {
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 18)
    }
    
    private let closeButton = UIButton().then() {
        $0.setImage(UIImage(systemName: "multiply"), for: .normal)
        $0.sizeToFit()
    }
    
    private let uploadButton = UIButton().then() {
        $0.setTitle("업로드 하기", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
    }
    
    @objc func closeButtonAction(sender: UIButton!) {
        dismiss(animated: true) {
            self.document?.close(completionHandler: nil)
        }
        
    }
    
    @objc func uploadButtonAction(sender: UIButton!) {
        if(document == nil){
            DispatchQueue.main.async {
                let alert: UIAlertController = UIAlertController(title: "오류", message: "문서가 비어있습니다.", preferredStyle: .alert)
                let action: UIAlertAction = UIAlertAction(title: "확인", style: .default)
                alert.addAction(action)
                self.present(alert, animated: true)
            }
        }else {
            let returnCheck = OrderVC.setDocument(document: document)
            if returnCheck == false  {
                DispatchQueue.main.async {
                    let alert: UIAlertController = UIAlertController(title: "오류", message: "문서 업로드가 정상적으로 동작되지 않았습니다. 다시 시도하여 주십시오.", preferredStyle: .alert)
                    let action: UIAlertAction = UIAlertAction(title: "확인", style: .default)
                    alert.addAction(action)
                    self.present(alert, animated: true)
                }
            }
        }
        dismiss(animated: true) {
            self.document?.close(completionHandler: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Access the document
        document?.open(completionHandler: { (success) in
            if success {
                // Display the content of the document, e.g.:
                self.titleLabel.text = self.document?.fileURL.lastPathComponent
            } else {
                // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
            }
        })
    }
    
    private func createUI() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        view.addSubview(uploadButton)
    
        closeButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(70)
            make.trailing.equalToSuperview().offset(-30)
            closeButton.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
        }
        
        uploadButton.snp.makeConstraints{ make in
            make.centerX.centerY.equalToSuperview()
            uploadButton.addTarget(self, action: #selector(uploadButtonAction), for: .touchUpInside)
        }
        
        titleLabel.snp.makeConstraints{ make in
            make.bottom.equalTo(uploadButton.safeAreaLayoutGuide.snp.top).offset(-20)
            make.centerX.equalToSuperview()
        }
    }
}

