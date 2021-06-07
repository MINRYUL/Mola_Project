//
//  ChargeVC.swift
//  Mola
//
//  Created by 김민창 on 2021/05/29.
//

import UIKit

class ChargeVC: UIViewController {
    
    var point: String?
    let pointURL: String = "http://13.209.232.235:8080/user/updatePoint/"
    
    lazy var rightRequestItem = UIBarButtonItem(title: "충전하기", style: .plain, target: self, action: #selector(chargeButtonPressed))
    
    private var chargePointField = SloyTextField().then {
        $0.placeholder = "충전할 금액을 입력해주세요."
        $0.largeContentTitle = "충전"
        $0.tintColor = .systemTeal
        $0.textContentType = .telephoneNumber
    }
    
    @objc
    private func popView(_ sender: UIAlertAction) {
       self.navigationController?.popViewController(animated: true)
    }
    
    @objc func chargeButtonPressed(sender: UIBarButtonItem!) {
        print("push charge button")
        var checkInput: Bool = true
        var errorString: String = "알 수 없는 오류입니다."
        
        if Int(point!) ?? 0 < 100 {
            checkInput = false
            errorString = "100원 이상만 충전 가능합니다."
        }
        
        if checkInput {
            let id = UserDefaults.standard.value(forKey: "UserId") as! Int
            let resultURL: String = "\(pointURL)\(id)/\(point!)"
            MolaApi.shared.changeUserPoint(requestURL: resultURL) { res in
                switch res.result{
                case .success(let data):
                    if let jsonString = String(data: data, encoding: .utf8){
                        if let jsonDict: [String: Any] = UtilityManager.shared.jsonStringToDictionary(jsonString: jsonString){
                            print(jsonDict)
                            if let status : Int = jsonDict["status"] as? Int {
                                if status == 200 {
                                    if let point : Int = jsonDict["point"] as? Int {
                                        UserDefaults.standard.set(point, forKey: "UserPoint")
                                        DispatchQueue.main.async {
                                            let alert: UIAlertController = UIAlertController(title: "성공", message: "충전이 완료되었습니다!", preferredStyle: .alert)
                                            let action: UIAlertAction = UIAlertAction(title: "확인", style: .default, handler: self.popView)
                                            alert.addAction(action)
                                            self.present(alert, animated: true)
                                        }
                                    } else {
                                        checkInput = false
                                        errorString = "다시 충전을 시도해주세요."
                                    }
                                } else {
                                    checkInput = false
                                    errorString = "네트워크 상태를 확인해주세요."
                                }
                            } else {
                                checkInput = false
                            }
                            
                            if checkInput == false {
                                DispatchQueue.main.async {
                                    let alert: UIAlertController = UIAlertController(title: "오류", message: errorString, preferredStyle: .alert)
                                    let action: UIAlertAction = UIAlertAction(title: "확인", style: .default)
                                    alert.addAction(action)
                                    self.present(alert, animated: true)
                                }
                            }
                        }
                    }
                case .failure(let err):
                    print("err")
                    print(err)
                }
            }
        } else {
            let alert: UIAlertController = UIAlertController(title: "오류", message: errorString, preferredStyle: .alert)
            let action: UIAlertAction = UIAlertAction(title: "확인", style: .default)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpNavigation()
        createUI()
    }
    
    private func setUpNavigation() {
        self.navigationItem.setRightBarButton(rightRequestItem, animated: true)
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    private func createUI() {
        view.backgroundColor = .white
        view.addSubview(chargePointField)
        
        chargePointField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(35)
            make.trailing.equalToSuperview().offset(-35)
            make.centerY.equalToSuperview().offset(-100)
            make.height.equalTo(70)
        }
        
        self.chargePointField.delegate = self
        self.chargePointField.addTarget(self, action: #selector(valueChanged), for: .editingChanged)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    static private var instance: ChargeVC? = nil
    
    static func getInstance() -> ChargeVC {
        if(instance == nil) {
            instance = ChargeVC()
        }
        return instance!
    }
}

extension ChargeVC : UITextFieldDelegate {
    @objc
    private func valueChanged(_ textField: SloyTextField) {
        self.point = textField.text
        if let _: String = point {
            if point?.count == 0 {
                self.navigationItem.rightBarButtonItem?.isEnabled = false
            } else {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
            }
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
}
