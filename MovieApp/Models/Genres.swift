//
//  Genres.swift
//  MovieApp
//
//  Created by bungkhus on 15/01/18.
//  Copyright © 2018 Bungkhus. All rights reserved.
//

import RealmSwift
import SwiftyJSON

class Genres: Object {
    
    @objc dynamic var identifier: Int64 = 0
    @objc dynamic var name: String?
    
    override public static func primaryKey() -> String? {
        return "identifier"
    }
    
    public static func with(realm: Realm, json: JSON) -> Genres? {
        let identifier = json["id"].int64Value
        if identifier == 0 {
            return nil
        }
        var obj = realm.object(ofType: Genres.self, forPrimaryKey: identifier)
        if obj == nil {
            obj = Genres()
            obj?.identifier = identifier
        } else {
            obj = Genres(value: obj!)
        }
        
        if json["name"].exists() {
            obj?.name = json["name"].string
        }
        
        return obj
    }
    
    public static func with(json: JSON) -> Genres? {
        return with(realm: try! Realm(), json: json)
    }
    
}
