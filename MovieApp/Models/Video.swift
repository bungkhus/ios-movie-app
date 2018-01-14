//
//  Video.swift
//  MovieApp
//
//  Created by bungkhus on 15/01/18.
//  Copyright © 2018 Bungkhus. All rights reserved.
//

import RealmSwift
import SwiftyJSON

class Video: Object {
    
    @objc dynamic var identifier: String = "0"
    @objc dynamic var name: String?
    @objc dynamic var key: String?
    
    override public static func primaryKey() -> String? {
        return "identifier"
    }
    
    public static func with(realm: Realm, json: JSON) -> Video? {
        let identifier = json["cast_id"].stringValue
        if identifier == "0" {
            return nil
        }
        var obj = realm.object(ofType: Video.self, forPrimaryKey: identifier)
        if obj == nil {
            obj = Video()
            obj?.identifier = identifier
        } else {
            obj = Video(value: obj!)
        }
        
        if json["name"].exists() {
            obj?.name = json["name"].string
        }
        if json["key"].exists() {
            obj?.key = json["key"].string
        }
        
        return obj
    }
    
    public static func with(json: JSON) -> Video? {
        return with(realm: try! Realm(), json: json)
    }
    
}
