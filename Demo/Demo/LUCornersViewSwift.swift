//
//  LUCornersViewSwift.swift
//  Lib_UI
//
//  Created by abiaoyo on 2025/2/20.
//

import UIKit

open class LUCornersViewSwift: LUFastViewSwift {
    
    public var enableRoundedCorner: Bool = false
    public var rectCorner: UIRectCorner = .allCorners
    public var cornerRadii: CGSize = .zero
    public var isHalfHeightCornerRadii: Bool = false

    open override func layoutSubviews() {
        super.layoutSubviews()
        
        if enableRoundedCorner {
            if isHalfHeightCornerRadii {
                self.layer.mask = nil;
                self.layer.cornerRadius = self.bounds.size.height/2.0
            }else{
                self.layer.cornerRadius = 0;
                
                let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: rectCorner, cornerRadii: cornerRadii)
                let maskLayer = CAShapeLayer()
                maskLayer.frame = bounds
                maskLayer.path = maskPath.cgPath
                self.layer.mask = maskLayer
            }
        }else{
            self.layer.mask = nil;
        }
    }

}
