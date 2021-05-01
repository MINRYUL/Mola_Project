//
//  BottomDrawerSupplemental.swift
//  Mola
//
//  Created by 김민창 on 2021/05/01.
//

import UIKit
import MaterialComponents.MaterialColorScheme
import MaterialComponents.MaterialNavigationDrawer

class DrawerContentViewController: UIViewController {
  var preferredHeight: CGFloat = 2000
  let bodyLabel : UILabel = {
    let label = UILabel(frame: .zero)
    label.text = "Example body"
    label.sizeToFit()
    return label
  }()

  override var preferredContentSize: CGSize {
    get {
      return CGSize(width: view.bounds.width, height: preferredHeight)
    }
    set {
      super.preferredContentSize = newValue
    }
  }

  init() {
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(bodyLabel)
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    bodyLabel.center =
      CGPoint(x: self.view.frame.size.width / 2, y: 20)
  }

}

class DrawerHeaderViewController: UIViewController,MDCBottomDrawerHeader {
  let preferredHeight: CGFloat = 80

  lazy var closeButton: UIButton = {
    let button = UIButton()
    button.setTitle("Close", for: .normal)
    button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    button.setTitleColor(.black, for: .normal)
    return button
  }()

  let titleLabel : UILabel = {
    let label = UILabel(frame: .zero)
    label.text = "Example Header"
    label.accessibilityTraits = .header
    label.sizeToFit()
    return label
  }()

  override var preferredContentSize: CGSize {
    get {
      return CGSize(width: view.bounds.width, height: preferredHeight)
    }
    set {
      super.preferredContentSize = newValue
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(closeButton)
    view.addSubview(titleLabel)
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    closeButton.sizeToFit()
    closeButton.center = CGPoint(x: 30, y: self.preferredHeight - 20)
    titleLabel.center = CGPoint(x: self.view.frame.size.width / 2, y: self.preferredHeight - 20)
  }

  @objc
  func closeButtonTapped() {
    dismiss(animated: true)
  }
}
