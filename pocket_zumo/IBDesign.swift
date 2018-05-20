//
//  IBDesign.swift
//  maccha
//
//  Created by 山田真也 on 2016/12/28.
//  Copyright © 2016年 YUMAKOMORI. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class CustomButton: UIButton{
    @IBInspectable var borderWidth: CGFloat = 0.0
    @IBInspectable var corderRadius: CGFloat = 0.0
    @IBInspectable var borderColor: UIColor = UIColor.clear
    
    override func draw(_ rect: CGRect) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = corderRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    
}

@IBDesignable class CustomLabel: UILabel{
    @IBInspectable var borderWidth: CGFloat = 0.0
    @IBInspectable var corderRadius: CGFloat = 0.0
    @IBInspectable var borderColor: UIColor = UIColor.clear
    
    override func draw(_ rect: CGRect) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = corderRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }

}

@IBDesignable class CustomView: UIView{
    @IBInspectable var borderWidth: CGFloat = 0.0
    @IBInspectable var corderRadius: CGFloat = 0.0
    @IBInspectable var borderColor: UIColor = UIColor.clear
    
    override func draw(_ rect: CGRect) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = corderRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }

}

