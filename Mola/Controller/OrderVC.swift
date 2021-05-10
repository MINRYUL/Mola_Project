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

class OrderVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate, CropViewControllerDelegate {

    private let scrollView = UIScrollView().then() {
        $0.backgroundColor = .systemBackground
        $0.isScrollEnabled = true
        $0.sizeToFit()
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
    
    private var uploadButton = UIImageView().then() {
        $0.image = UIImage(systemName: "chevron.forward")
        $0.tintColor = .black
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
    
    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        return picker
    }()
        
    
    func cropViewControllerDidCrop(_ cropViewController: CropViewController, cropped: UIImage, transformation: Transformation) {
        self.exampleImage.image = cropped
        self.exampleImage.backgroundColor = .white
        dismiss(animated: true, completion: nil)
    }
    
    func cropViewControllerDidCancel(_ cropViewController: CropViewController, original: UIImage) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        let cropViewController = Mantis.cropViewController(image: originalImage!)
        cropViewController.delegate = self
        self.present(cropViewController, animated: true)
    }
    
    @objc private func touchUpSelectImageButton(_ sender: UITapGestureRecognizer) {
        self.present(self.imagePicker, animated: true, completion: nil)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpNavigation()
        createUI()
    }
    
    private func setUpNavigation() {
        self.navigationItem.title = "외주 등록"
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 51/225, green: 153/255, blue: 255/255, alpha:1.0)
        
        tabBarController?.tabBar.barTintColor = UIColor(red: 51/225, green: 153/255, blue: 255/255, alpha:1.0)
        tabBarController?.tabBar.tintColor = UIColor.white
    }
    
    private func createUI() {
        self.view.backgroundColor = .white
        scrollView.delegate = self
        
        view.addSubview(scrollView)
        scrollView.addSubview(labelingText)
        scrollView.addSubview(uploadLabel)
        scrollView.addSubview(uploadButton)
        scrollView.addSubview(creditText)
        scrollView.addSubview(imageExampleText)
        scrollView.addSubview(exampleImage)
        scrollView.addSubview(requirementsLabel)
        scrollView.addSubview(requirementsText)
        
        scrollView.snp.makeConstraints{ maker in
            maker.edges.equalTo(view)
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

}
