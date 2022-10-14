//
//  Style.swift
//  AR Student ID
//
//  Created by 김민채 on 2022/10/13.
//

import Foundation
import UIKit

class viewStyle: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var bordercolor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = bordercolor.cgColor
        }
    }
}
