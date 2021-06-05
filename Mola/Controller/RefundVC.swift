//
//  refundVC.swift
//  Mola
//
//  Created by 김민창 on 2021/06/05.
//

import UIKit

class RefundVC: UIViewController {
    
    lazy var rightRequestItem = UIBarButtonItem(title: "환급받기", style: .plain, target: self, action: #selector(refundButtonPressed))
    
    private var refundPointField = SloyTextField().then {
        $0.placeholder = "환급 받을 금액을 입력해주세요."
        $0.largeContentTitle = "환급"
        $0.tintColor = .systemTeal
    }
    
    @objc func refundButtonPressed(sender: UIBarButtonItem!) {
        print("push refund button")
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
        view.addSubview(refundPointField)
        
        refundPointField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(35)
            make.trailing.equalToSuperview().offset(-35)
            make.centerY.equalToSuperview().offset(-100)
            make.height.equalTo(70)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    static private var instance: RefundVC? = nil
    
    static func getInstance() -> RefundVC {
        if(instance == nil) {
            instance = RefundVC()
        }
        return instance!
    }

}
