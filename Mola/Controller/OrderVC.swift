//
//  OrderVC.swift
//  Mola
//
//  Created by 김민창 on 2021/05/05.
//

import UIKit
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import Mantis

class OrderVC: UIViewController, UINavigationControllerDelegate, UIScrollViewDelegate {
    
    var hostViewController: UIViewController? = nil
    
    static private var instance: OrderVC? = nil
    static private var documentInstance: Document? = nil
    
    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        return picker
    }()

    lazy var rightRequestItem = UIBarButtonItem(title: "완료하기", style: .plain, target: self, action: #selector(requestButtonPressed))
    
    private let scrollView = UIScrollView().then() {
        $0.backgroundColor = .systemBackground
        $0.isScrollEnabled = true
        $0.sizeToFit()
    }
    
    private let contentView = UIView().then() {
        $0.backgroundColor = .systemBackground
    }
    
    private var labelingText = MDCFilledTextField().then() {
        $0.font = .systemFont(ofSize: 20)
        $0.label.text = "라벨링"
        $0.placeholder = "의뢰할 라벨링 제목 작성"
        $0.sizeToFit()
        $0.tintColor = .systemGray
        $0.sizeToFit()
    }
    
    private var uploadLabel = UILabel().then() {
        $0.font = .systemFont(ofSize: 15)
        $0.text = "업로드 파일 선택"
        $0.textColor = .darkGray
    }

    private var uploadButton = UIButton().then() {
        $0.setImage(UIImage(systemName: "chevron.forward"),for: .normal)
        $0.sizeToFit()
    }
    
    private var creditText = MDCFilledTextField().then() {
        $0.font = .systemFont(ofSize: 15)
        $0.label.text = "크레딧"
        $0.placeholder = "사진 한장 당 보상 크레딧 설정"
        $0.tintColor = .systemGray
        $0.sizeToFit()
    }
    
    private var imageExampleText = UILabel().then() {
        $0.font = .systemFont(ofSize: 15)
        $0.text = "이미지 예시를 설정 해주세요."
        $0.textColor = .darkGray
    }
    
    private var exampleImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .lightGray
    }
    
    private var requirementsLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 17)
        $0.text = "요구사항"
        $0.textColor = .darkGray
    }
    
    private var requirementsText = MDCFilledTextArea().then() {
        $0.tintColor = .systemGray
        $0.sizeToFit()
    }
    
    @objc func requestButtonPressed(sender: UIBarButtonItem!) {
        print("push complete Button")
        var checkInput : Bool! = true
        var errorString : String! = "알 수 없는 오류"
        
        do {
            let data = try Data(contentsOf: OrderVC.documentInstance!.fileURL)
            
            MolaApi.shared.uploadDocument(requestURL: "https://yourserverurl", file: data, filename: (OrderVC.documentInstance?.fileURL.lastPathComponent)!) { res in
                switch res.result{
                case .success(let data):
                    if let jsonString = String(data: data, encoding: .utf8){
                        if let jsonDict: [String: Any] = UtilityManager.shared.jsonStringToDictionary(jsonString: jsonString){
                            print(jsonDict)
                            print(jsonDict["status"] ?? "오류")
                            if let status : Int = jsonDict["status"] as? Int {
                                if status >= 400{
                                    checkInput = false
                                    errorString = "네트워크 연결이 불안정합니다."
                                }
                            }
                            if checkInput == false {
                                DispatchQueue.main.async {
                                    let alert: UIAlertController = UIAlertController(title: "오류", message: errorString!, preferredStyle: .alert)
                                    let action: UIAlertAction = UIAlertAction(title: "확인", style: .default)
                                    alert.addAction(action)
                                    self.present(alert, animated: true)
                                }
                            }
                        }
                    }
                case .failure(let err):
                    print("err발생")
                    print(err)
                }
            }
        } catch {
            DispatchQueue.main.async {
                let alert: UIAlertController = UIAlertController(title: "오류", message: "업로드 파일을 다시 확인해 주세요.", preferredStyle: .alert)
                let action: UIAlertAction = UIAlertAction(title: "확인", style: .default)
                alert.addAction(action)
                self.present(alert, animated: true)
            }
        }
    }
    
    @objc func uploadButtonAction(sender: UIButton!) {

        DispatchQueue.main.async {
            let alert: UIAlertController = UIAlertController(title: "알림", message: ".zip으로 압축된 파일만 업로드 가능합니다!", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default) { (action) in
                let documentVC = DocumentBrowserVC.getInstance()
                documentVC.hostViewController = self
                self.present(documentVC, animated: true, completion: nil)
            }
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpNavigation()
        createUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if OrderVC.documentInstance == nil {
            uploadLabel.text = "업로드 파일 선택"
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            uploadLabel.text = OrderVC.documentInstance?.fileURL.lastPathComponent
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setUpNavigation() {
        self.navigationItem.title = "외주 등록"
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 51/225, green: 153/255, blue: 255/255, alpha:1.0)
        self.navigationItem.setRightBarButton(rightRequestItem, animated: true)
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    private func createUI() {
        self.view.backgroundColor = .white
        self.scrollView.delegate = self
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(labelingText)
        contentView.addSubview(uploadLabel)
        contentView.addSubview(uploadButton)
        contentView.addSubview(creditText)
        contentView.addSubview(imageExampleText)
        contentView.addSubview(exampleImage)
        contentView.addSubview(requirementsLabel)
        contentView.addSubview(requirementsText)
        
        scrollView.snp.makeConstraints{ make in
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.edges.equalTo(view)
        }
        
        contentView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.top.bottom.equalTo(scrollView)
            make.left.right.equalTo(view)
        }
        
        labelingText.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
        }
        
        uploadLabel.snp.makeConstraints{ make in
            make.top.equalTo(labelingText.safeAreaLayoutGuide.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-100)
        }

        uploadButton.snp.makeConstraints{ make in
            make.top.equalTo(labelingText.safeAreaLayoutGuide.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(135)
            make.height.equalTo(18)
            uploadButton.addTarget(self, action: #selector(uploadButtonAction), for: .touchUpInside)
        }
        
        creditText.snp.makeConstraints{ make in
            make.top.equalTo(uploadLabel.safeAreaLayoutGuide.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
        }
        
        imageExampleText.snp.makeConstraints{ make in
            make.top.equalTo(creditText.safeAreaLayoutGuide.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-100)
        }
        
        exampleImage.snp.makeConstraints{ make in
            make.top.equalTo(imageExampleText.safeAreaLayoutGuide.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(310)
            make.centerX.equalToSuperview()
        }
        
        requirementsLabel.snp.makeConstraints{ make in
            make.top.equalTo(exampleImage.safeAreaLayoutGuide.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-100)
        }
        
        requirementsText.snp.makeConstraints{ make in
            make.top.equalTo(requirementsLabel.safeAreaLayoutGuide.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
        }
        
        let imageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(touchUpSelectImageButton(_:)))

        self.exampleImage.addGestureRecognizer(imageTapGestureRecognizer)
        exampleImage.isUserInteractionEnabled = true
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    static func getInstance() -> OrderVC {
        if(instance == nil) {
            instance = OrderVC()
        }
        return instance!
    }
    
    static func setDocument(document: Document?) -> Bool{
        if (document == nil) {
            return false
        }
        documentInstance = document
        if(self.instance != nil) {
            self.instance?.uploadLabel.text = self.documentInstance?.fileURL.lastPathComponent
            OrderVC.getInstance().navigationItem.rightBarButtonItem?.isEnabled = true
        }
        return true
    }

}

extension OrderVC: CropViewControllerDelegate {
    
    func cropViewControllerDidCrop(_ cropViewController: CropViewController, cropped: UIImage, transformation: Transformation) {
        self.exampleImage.image = cropped
        self.exampleImage.backgroundColor = .white
        dismiss(animated: true, completion: nil)
    }
    
    func cropViewControllerDidCancel(_ cropViewController: CropViewController, original: UIImage) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension OrderVC: UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        let cropViewController = Mantis.cropViewController(image: originalImage!)
        cropViewController.delegate = self
        cropViewController.modalPresentationStyle = .fullScreen
        self.present(cropViewController, animated: true)
    }
    
    @objc private func touchUpSelectImageButton(_ sender: UITapGestureRecognizer) {
        self.present(self.imagePicker, animated: true, completion: nil)
    }
}
