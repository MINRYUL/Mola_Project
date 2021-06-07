//
//  OutsourcingVC.swift
//  Mola
//
//  Created by 김민창 on 2021/05/19.
//

import UIKit
import Mantis

class OutsourcingVC: UIViewController, UINavigationControllerDelegate {
    
    let getImageURL: String = "http://13.209.232.235:8080/image"
    let pushLabelingInfoURL: String = "http://13.209.232.235:8080/image/"
    
    var initLabelingView: Bool = false
    var imageId: Int?
    var xCoordinate: Float = 0
    var yCoordinate: Float = 0
    var height: Float = 0
    var width: Float = 0
    
    lazy var leftRefrashItem = UIBarButtonItem(title: "새로고침", style: .plain, target: self, action: #selector(leftButtonPressed))
    
    lazy var rightCompleteItem = UIBarButtonItem(title: "다음사진", style: .plain, target: self, action: #selector(rightButtonPressed))
    
    private let detailImage = UIImageView().then() {
        $0.backgroundColor = .black
        $0.contentMode = .scaleAspectFit
    }
    
    private let explainLabel = UILabel().then() {
        $0.text = "이미지를 탭하여 라벨링 작업을 수행할 수 있습니다."
        $0.textColor = .darkGray
        $0.font = .systemFont(ofSize: 11)
    }
    
    private let creditabel = UILabel().then() {
        $0.text = " Point"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 13)
    }
    
    private let labelingView = UIView().then() {
        $0.backgroundColor = .white
        $0.alpha = 0.25
    }
    
    private let subView = UIView().then() {
        $0.backgroundColor = .systemGray6
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
    }
    
    private let requirementsLabel = UILabel().then() {
        $0.text = ""
        $0.font = .systemFont(ofSize: 17)
        $0.numberOfLines = 3
        $0.textColor = .darkGray
    }
    
    
    @objc func leftButtonPressed(sender: UIBarButtonItem!) {
        print("touch left navigationButton button")
        self.didReceiveOutSourceImage()
    }
    
    @objc func rightButtonPressed(sender: UIBarButtonItem!) {
        print("touch right navigationButton button")
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        var checkInput: Bool = true
        var errorString: String = "알 수 없는 에러입니다."
        
        if let id: Int = self.imageId {
            print(id)
        } else {
            checkInput = false
            errorString = "새로고침 이후 다시 시도해주세요."
        }
        
        if height == 0 || width == 0 {
            checkInput = false
            errorString = "새로고침 이후 다시 시도해주세요."
        }
        
        if checkInput {
            let lebeingInfo : LabelingImageInfo = {
                LabelingImageInfo(userId: UserDefaults.standard.value(forKey: "UserId") as! Int, xCoordinate: self.xCoordinate, yCoordinate: self.yCoordinate, height: self.height, width: self.width)
            }()
            
            let finalURL: String = "\(pushLabelingInfoURL)\(imageId!)"
            MolaApi.shared.pushLabelingImageInfo(requestURL: finalURL, info: lebeingInfo) { res in
                switch res.result{
                case .success(let data):
                    if let jsonString = String(data: data, encoding: .utf8){
                        if let jsonDict: [String: Any] = UtilityManager.shared.jsonStringToDictionary(jsonString: jsonString){
                            print(jsonDict)
                            self.didReceiveOutSourceImage()
                        }
                    }
                case .failure(let err):
                    print(err)
                }
            }
        } else {
        DispatchQueue.main.async {
            let alert: UIAlertController = UIAlertController(title: "오류", message: errorString, preferredStyle: .alert)
            let action: UIAlertAction = UIAlertAction(title: "확인", style: .default)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.barTintColor = .black
        setupNavigation()
        createUI()
        didReceiveOutSourceImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.barTintColor = .black
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.barTintColor = UIColor(red: 51/225, green: 153/255, blue: 255/255, alpha:1.0)
    }
    
    private func removeLebelingView() {
        if initLabelingView {
            labelingView.removeFromSuperview()
            initLabelingView = false
        }
    }
    
    private func didReceiveOutSourceImage() {
        removeLebelingView()
        MolaApi.shared.getOutSourceImage(requestURL: getImageURL) {
            res in
            switch res.result{
            case .success(let data):
                do {
                    let imageData: Image = try JSONDecoder().decode(Image.self, from: data)
                    DispatchQueue.global().async {
                        guard let imageURL: URL = URL(string: imageData.url) else { return }
                        guard let changeImage: Data = try? Data(contentsOf: imageURL) else { return }
                        DispatchQueue.main.async {
                            self.imageId = imageData.imageId
                            UIView.transition(with: self.detailImage,
                                              duration: 0.7,
                                              options: .transitionCrossDissolve,
                                              animations: {
                                                self.detailImage.image = UIImage(data: changeImage)
                                              }, completion: nil)
                            self.requirementsLabel.text = imageData.requirements
                            self.creditabel.text = "\(imageData.credit) 포인트 휙득 가능"
                        }
                    }
                    
                } catch(let err){
                    print(err)
                }
            case .failure(let err):
                print("err")
                print(err)
            }
        }
    }
    
    private func setLabelingView() {
        view.addSubview(labelingView)
        let imageSize = detailImage.contentClippingRect
        
        print(imageSize)
        labelingView.snp.makeConstraints{ make in
            make.top.equalTo(detailImage).offset((Float)(imageSize.origin.y) + self.yCoordinate)
            make.leading.equalTo(detailImage).offset((Float)(imageSize.origin.x) + self.xCoordinate)
            make.height.equalTo(self.height)
            make.width.equalTo(self.width)
        }
    }
    
    private func setupNavigation() {
        self.navigationItem.title = "일 하기"
        
        self.navigationItem.setLeftBarButton(leftRefrashItem, animated: true)
        self.navigationItem.setRightBarButton(rightCompleteItem, animated: true)
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = .black
    }
    
    private func createUI() {
        view.backgroundColor = .systemGray2
        view.addSubview(detailImage)
        view.addSubview(explainLabel)
        view.addSubview(creditabel)
        view.addSubview(subView)
        subView.addSubview(requirementsLabel)
        
        detailImage.snp.makeConstraints{ make in
            make.centerX.top.leading.trailing.equalToSuperview()
            make.height.equalTo(view.frame.width)
        }
        
        creditabel.snp.makeConstraints{ make in
            make.top.equalTo(detailImage.safeAreaLayoutGuide.snp.bottom).offset(7)
            make.leading.equalToSuperview().offset(15)
        }
        
        explainLabel.snp.makeConstraints{ make in
            make.top.equalTo(detailImage.safeAreaLayoutGuide.snp.bottom).offset(5)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        subView.snp.makeConstraints{ make in
            make.top.equalTo(creditabel.safeAreaLayoutGuide.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-100)
        }
        
        requirementsLabel.snp.makeConstraints{ make in
            make.top.leading.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        let imageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(touchUpSelectImageButton(_:)))

        self.detailImage.addGestureRecognizer(imageTapGestureRecognizer)
        detailImage.isUserInteractionEnabled = true
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

extension OutsourcingVC: CropViewControllerDelegate {
    
    func cropViewControllerDidCrop(_ cropViewController: CropViewController, cropped: UIImage, transformation: Transformation) {
        print(transformation)
        xCoordinate = Float(transformation.scrollBounds.minX)
        yCoordinate = Float(transformation.scrollBounds.minY)
        width = Float(cropped.getWidth)
        height = Float(cropped.getHeight)
        print(cropped.size.width)
        print(cropped.size.height)
        
        print(detailImage.image?.size.width)
        print(detailImage.image?.size.height)
        if initLabelingView == false {
            initLabelingView = true
            setLabelingView()
        } else {
            labelingView.removeFromSuperview()
            setLabelingView()
        }
        dismiss(animated: true, completion: nil)
        self.navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    func cropViewControllerDidCancel(_ cropViewController: CropViewController, original: UIImage) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func touchUpSelectImageButton(_ sender: UITapGestureRecognizer) {
        let cropViewController = Mantis.cropViewController(image: self.detailImage.image!)
        cropViewController.delegate = self
        cropViewController.modalPresentationStyle = .fullScreen
        self.present(cropViewController, animated: true)
    }
}
