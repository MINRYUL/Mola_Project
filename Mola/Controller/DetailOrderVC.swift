//
//  DetailOrderVC.swift
//  Mola
//
//  Created by 김민창 on 2021/05/18.
//

import UIKit

class DetailOrderVC: UIViewController {
    
    var outSourceModel: OutSource?
    var imageCount: Int?
    
    private let rightRefrashItem = UIBarButtonItem(title: "새로고침", style: .plain, target: self, action: #selector(buttonPressed))
    
    private let detailImage = UIImageView().then() {
        $0.backgroundColor = .black
        $0.contentMode = .scaleAspectFit
    }
    
    private let labelingView = UIView().then() {
        $0.backgroundColor = .white
        $0.alpha = 0.37
    }
    
    private let returnButton = UIButton().then() {
        $0.setTitle("반려하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .darkGray
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    private let explainLabel = UILabel().then() {
        $0.text = "라벨링이 완료된 사진들을 랜덤으로 보여줍니다."
        $0.textColor = .darkGray
        $0.font = .systemFont(ofSize: 11)
    }
    
    private let progressView = UIView().then() {
        $0.backgroundColor = .systemGray6
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 40
//        $0.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    private let progressLabel = UILabel().then() {
        $0.font = .boldSystemFont(ofSize: 22)
        $0.textColor = .black
    }
    
    private let progressBar = UIProgressView().then() {
        $0.progressTintColor = UIColor(red: 51/225, green: 153/255, blue: 255/255, alpha:1.0)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
    }
    
    @objc func buttonPressed(sender: UIBarButtonItem!) {
        print("touch navigationButton button")
        self.imageCount! += 1
        labelingView.removeFromSuperview()
        didChangeImageView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.setRightBarButtonItems([rightRefrashItem], animated: true)
        createUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = outSourceModel?.title
        self.navigationController?.navigationBar.barTintColor = .black
        self.tabBarController?.tabBar.isHidden = true
        setProgress()
        didChangeImageView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 51/225, green: 153/255, blue: 255/255, alpha:1.0)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func didChangeImageView(){
        DispatchQueue.global().async {
            guard let imageURL: URL = URL(string: (self.outSourceModel?.completedImageList[self.imageCount!].url)!) else { return }
            guard let changeImage: Data = try? Data(contentsOf: imageURL) else { return }
            DispatchQueue.main.async {
                UIView.transition(with: self.detailImage,
                                  duration: 0.7,
                                  options: .transitionCrossDissolve,
                                  animations: {
                                    self.detailImage.image = UIImage(data: changeImage)
                                  }, completion: nil)
                self.setLabelingView()
            }
        }
    }
    
    private func setLabelingView() {
        view.addSubview(labelingView)
        
        labelingView.snp.makeConstraints{ make in
            make.top.equalTo(detailImage).offset((self.outSourceModel?.completedImageList[self.imageCount!].xcoordinate)!)
            make.leading.equalTo(detailImage).offset((self.outSourceModel?.completedImageList[self.imageCount!].ycoordinate)!)
            make.height.equalTo((self.outSourceModel?.completedImageList[self.imageCount!].height)!)
            make.width.equalTo((self.outSourceModel?.completedImageList[self.imageCount!].width)!)
        }
    }

    private func createUI() {
        view.backgroundColor = .systemGray4
        view.addSubview(detailImage)
        view.addSubview(returnButton)
        view.addSubview(explainLabel)
        view.addSubview(progressView)
        progressView.addSubview(progressLabel)
        progressView.addSubview(progressBar)
        
        detailImage.snp.makeConstraints{ make in
            make.centerX.top.leading.trailing.equalToSuperview()
            make.height.equalTo(view.frame.width)
        }
    
        explainLabel.snp.makeConstraints{ make in
            make.top.equalTo(detailImage.safeAreaLayoutGuide.snp.bottom).offset(5)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        returnButton.snp.makeConstraints{ make in
            make.top.equalTo(detailImage.safeAreaLayoutGuide.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(5)
            make.width.equalTo(150)
            make.height.equalTo(35)
        }
        
        progressView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalTo(returnButton.safeAreaLayoutGuide.snp.bottom).offset(10)
            make.height.equalTo(200)
        }
        
        progressLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(50)
        }
        
        progressBar.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(progressLabel.safeAreaLayoutGuide.snp.bottom).offset(38)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(15)
        }
    }
    
    private func setProgress() {
        let progressValue : Float = ((Float)(outSourceModel?.imgCompleted ?? 0) / (Float)(outSourceModel?.imgTotal ?? 0)) * 100
        let progress = Progress(totalUnitCount: 100)
        
        progress.completedUnitCount = 0
        
        progressBar.progress = 0.0
        progress.completedUnitCount = Int64(progressValue)
        progressBar.setProgress(Float(progress.fractionCompleted), animated: true)
        
        progressLabel.text = "\(progressValue) % 완료되었습니다!"
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
