//
//  ChargeVC.swift
//  Mola
//
//  Created by 김민창 on 2021/05/29.
//

import UIKit

class ChargeVC: UIViewController {
    
    private let chargeLabel = UILabel().then() {
        $0.text = "충전하기"
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textColor = .systemBlue
    }
    
    private var chargePointField = SloyTextField().then {
        $0.placeholder = "충전할 금액을 입력해주세요."
        $0.largeContentTitle = "충전"
        $0.tintColor = .systemTeal
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        createUI()
    }
    
    
    private func createUI() {
        view.backgroundColor = .white
        view.addSubview(chargeLabel)
        view.addSubview(chargePointField)
        
        chargePointField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(35)
            make.trailing.equalToSuperview().offset(-35)
            make.centerY.equalToSuperview().offset(-120)
            make.height.equalTo(70)
        }
        
        chargePointField.snp.makeConstraints{ make in
            make.leading.equalTo(chargePointField)
            make.bottom.equalTo(chargePointField.safeAreaLayoutGuide.snp.top).offset(-30)
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

    static private var instance: ChargeVC? = nil
    
    static func getInstance() -> ChargeVC {
        if(instance == nil) {
            instance = ChargeVC()
        }
        return instance!
    }
}
