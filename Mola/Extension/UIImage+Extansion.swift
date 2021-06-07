//
//  UIImage+Extansion.swift
//  Mola
//
//  Created by 김민창 on 2021/06/07.
//

import UIKit

extension UIImage {

    var getWidth: CGFloat {
        get {
            let width = self.size.width
            return width
        }
    }

    var getHeight: CGFloat {
        get {
            let height = self.size.height
            return height
        }
    }
}
