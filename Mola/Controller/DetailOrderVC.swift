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
    
    lazy var rightRefrashItem = UIBarButtonItem(title: "다음사진", style: .plain, target: self, action: #selector(buttonPressed))
    
    private let detailImage = UIImageView().then() {
        $0.backgroundColor = .black
        $0.contentMode = .scaleAspectFit
    }
    
    private let labelingView = UIView().then() {
        $0.backgroundColor = .gray
        $0.alpha = 0.45
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.black.cgColor
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
        
        print(outSourceModel?.completedImageList.count)
        if (outSourceModel?.completedImageList.count ?? 0) - 1 <= self.imageCount ?? 0 {
            let alert: UIAlertController = UIAlertController(title: "알림", message: "현재까지 완료된 마지막 사진입니다.", preferredStyle: .alert)
            let action: UIAlertAction = UIAlertAction(title: "확인", style: .default)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        } else {
            self.imageCount! += 1
            labelingView.removeFromSuperview()
            didChangeImageView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.setRightBarButton(rightRefrashItem, animated: true)
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
        let imageSize = detailImage.contentClippingRect
        
        let viewPos: CGPoint = CGPoint(x: ((Double)(imageSize.origin.x) + (self.outSourceModel?.completedImageList[imageCount!].xcoordinate ?? 0)), y: ((Double)(imageSize.origin.y) + (self.outSourceModel?.completedImageList[imageCount!].ycoordinate ?? 0)))
        
        let viewSize: CGSize = CGSize(width: ((Double)(imageSize.size.width) * (self.outSourceModel?.completedImageList[imageCount!].width ?? 0)), height: ((Double)(imageSize.size.height) * (self.outSourceModel?.completedImageList[imageCount!].height ?? 0)))
        
        let rect: CGRect = .init(origin: viewPos, size: viewSize)
        
        labelingView.frame = rect
    }

    private func createUI() {
        view.backgroundColor = .systemGray4
        view.addSubview(detailImage)
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
        
        progressView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalTo(explainLabel.safeAreaLayoutGuide.snp.bottom).offset(20)
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
        
        progressLabel.text = "\(progressValue) % 완료되었습니다."
    }
}
