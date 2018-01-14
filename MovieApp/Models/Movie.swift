//
//  Movie.swift
//  MovieApp
//
//  Created by bungkhus on 14/01/18.
//  Copyright © 2018 Bungkhus. All rights reserved.
//

import RealmSwift
import SwiftyJSON

class Movie: Object {
    
//    "poster_path": "/lFSSLTlFozwpaGlO31OoUeirBgQ.jpg",
//    "adult": false,
//    "overview": "The most dangerous former operative of the CIA is drawn out of hiding to uncover hidden truths about his past.",
//    "release_date": "2016-07-27",
//    "genre_ids": [
//    28,
//    53
//    ],
//    "id": 324668,
//    "original_title": "Jason Bourne",
//    "original_language": "en",
//    "title": "Jason Bourne",
//    "backdrop_path": "/AoT2YrJUJlg5vKE3iMOLvHlTd3m.jpg",
//    "popularity": 30.690177,
//    "vote_count": 649,
//    "video": false,
//    "vote_average": 5.25
    
    @objc dynamic var identifier: Int64 = 0
    @objc dynamic var title: String?
    @objc dynamic var desc: String?
    @objc dynamic var startDate: Date?
    @objc dynamic var endDate: Date?
    
    override public static func primaryKey() -> String? {
        return "identifier"
    }
    
    public static func with(realm: Realm, json: JSON) -> Agenda? {
        let identifier = json["id"].int64Value
        if identifier == 0 {
            return nil
        }
        var obj = realm.object(ofType: Agenda.self, forPrimaryKey: identifier)
        if obj == nil {
            obj = Agenda()
            obj?.identifier = identifier
        } else {
            obj = Agenda(value: obj!)
        }
        
        if json["title"].exists() {
            obj?.title = json["title"].string
        }
        
        if json["description"].exists() {
            obj?.desc = json["description"].string
        }
        
        return obj
    }
    
    public static func with(json: JSON) -> Agenda? {
        return with(realm: try! Realm(), json: json)
    }
    
}
