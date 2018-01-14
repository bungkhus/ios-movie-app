//
//  Cast.swift
//  MovieApp
//
//  Created by bungkhus on 15/01/18.
//  Copyright © 2018 Bungkhus. All rights reserved.
//

import RealmSwift
import SwiftyJSON

class Cast: Object {
    
    @objc dynamic var identifier: Int64 = 0
    @objc dynamic var name: String?
    @objc dynamic var character: String?
    @objc dynamic var profilePath: String?
    
    override public static func primaryKey() -> String? {
        return "identifier"
    }
    
    public static func with(realm: Realm, json: JSON) -> Cast? {
        let identifier = json["cast_id"].int64Value
        if identifier == 0 {
            return nil
        }
        var obj = realm.object(ofType: Cast.self, forPrimaryKey: identifier)
        if obj == nil {
            obj = Cast()
            obj?.identifier = identifier
        } else {
            obj = Cast(value: obj!)
        }
        
        if json["name"].exists() {
            obj?.name = json["name"].string
        }
        if json["character"].exists() {
            obj?.character = json["character"].string
        }
        if json["profile_path"].exists() {
            obj?.profilePath = json["profile_path"].string
        }
        
        return obj
    }
    
    public static func with(json: JSON) -> Cast? {
        return with(realm: try! Realm(), json: json)
    }
    
}
