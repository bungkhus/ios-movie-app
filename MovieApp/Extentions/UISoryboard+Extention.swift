//
//  UISoryboard+Extention.swift
//  Kongres PSSI
//
//  Created by bungkhus on 08/01/18.
//  Copyright © 2018 suitmedia. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    static var message: UIStoryboard {
        return UIStoryboard(name: "Message", bundle: nil)
    }
    
    static var map: UIStoryboard {
        return UIStoryboard(name: "Map", bundle: nil)
    }
    
    static var schedule: UIStoryboard {
        return UIStoryboard(name: "Schedule", bundle: nil)
    }
    
    static var setting: UIStoryboard {
        return UIStoryboard(name: "Setting", bundle: nil)
    }
    
    static var module: UIStoryboard {
        return UIStoryboard(name: "Module", bundle: nil)
    }
}
