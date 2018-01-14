//
//  KeyedValue.swift
//  MovieAppCore
//
//  Created by Rifat Firdaus on 11/18/16.
//  Copyright © 2016 Suitmedia. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

open class KeyedValue: Object {

    @objc dynamic open var key: String = ""
    @objc dynamic open var value: String?
    
    override open static func primaryKey() -> String? {
        return "key"
    }
}
