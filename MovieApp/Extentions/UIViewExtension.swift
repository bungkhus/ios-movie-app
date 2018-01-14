//
//  UIViewExtension.swift
//
//
//  Copyright © 2016 Suitmedia. All rights reserved.
//

import UIKit

extension UIView {
    
    func cardify() {
        layer.masksToBounds = false
        clipsToBounds = false
        
        layer.cornerRadius = 0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 1
    }
    
    func circlify(masked: Bool = false) {
        let roundValue = frame.width / 2
        layer.cornerRadius = roundValue
        layer.shadowColor = UIColor.black.cgColor
        var shadowOpacity: Float = 1.0
        if masked {
            shadowOpacity = 0.0
        }
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 5
        
        layer.masksToBounds = masked
        clipsToBounds = masked
    }
    
    func circlify(masked: Bool = false, opacity:Float, radius: Float, heightOffset: Int) {
        let roundValue = frame.width / 2
        layer.cornerRadius = roundValue
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: 0, height: heightOffset)
        layer.shadowRadius = CGFloat(radius)
        
        layer.masksToBounds = masked
        clipsToBounds = masked
    }
    
    func setShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 2
    }
    
    func shadowItem() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 3
    }
    
    func cardifyItem() {
        layer.masksToBounds = false
        clipsToBounds = false
        
        layer.cornerRadius = 0
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 3
    }
    
    func roundifyItem() {
        layer.masksToBounds = false
        clipsToBounds = false
        
        layer.cornerRadius = 4
    }
    
    func normalize() {
        layer.masksToBounds = false
        clipsToBounds = false
        
        layer.cornerRadius = 0
        layer.shadowColor = UIColor.clear.cgColor
        layer.shadowOpacity = 0
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 0
    }
    
    func loadingIndicatorInView(_ show: Bool) {
        let tag = 808404
        if show {
            self.alpha = 0.5
            let indicator = UIActivityIndicatorView()
            let buttonHeight = self.bounds.size.height
            let buttonWidth = self.bounds.size.width
            indicator.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
            indicator.tag = tag
            indicator.activityIndicatorViewStyle = .white
            self.addSubview(indicator)
            indicator.startAnimating()
        } else {
            self.alpha = 1.0
            if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
}
