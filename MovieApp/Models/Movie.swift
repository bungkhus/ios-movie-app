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
    
    @objc dynamic var identifier: Int64 = 0
    @objc dynamic var title: String?
    @objc dynamic var desc: String?
    @objc dynamic var posterPath: String?
    @objc dynamic var backdropPath: String?
    @objc dynamic var originalLanguage: String?
    @objc dynamic var voteAverage: Double = 0
    @objc dynamic var gendres: String?
    @objc dynamic var voteCount: Int64 = 0
    @objc dynamic var runtime: Int64 = 0
    @objc dynamic public var releaseDate: NSDate?
    
    override public static func primaryKey() -> String? {
        return "identifier"
    }
    
    public static func with(realm: Realm, json: JSON) -> Movie? {
        let identifier = json["id"].int64Value
        if identifier == 0 {
            return nil
        }
        var obj = realm.object(ofType: Movie.self, forPrimaryKey: identifier)
        if obj == nil {
            obj = Movie()
            obj?.identifier = identifier
        } else {
            obj = Movie(value: obj!)
        }
        
        if json["title"].exists() {
            obj?.title = json["title"].string
        }
        if json["overview"].exists() {
            obj?.desc = json["overview"].string
        }
        if json["original_language"].exists() {
            obj?.originalLanguage = json["original_language"].string
        }
        if json["poster_path"].exists() {
            obj?.posterPath = json["poster_path"].string
        }
        if json["backdrop_path"].exists() {
            obj?.backdropPath = json["backdrop_path"].string
        }
        if json["vote_average"].exists() {
            obj?.voteAverage = json["vote_average"].doubleValue
        }
        if json["vote_count"].exists() {
            obj?.voteCount = json["vote_count"].int64Value
        }
        if json["runtime"].exists() {
            obj?.runtime = json["runtime"].int64Value
        }
        if json["release_date"].exists() {
            obj?.releaseDate = DateHelper.iso8601(dateString: json["release_date"].stringValue) as NSDate?
        }
        if json["genres"].exists() {
            let genresJson = json["genres"]
            if genresJson.arrayValue.count > 0 {
                var tempString = ""
                for itemJson in genresJson.arrayValue {
                    if let item = Genres.with(json: itemJson) {
                        if let name = item.name {
                            if tempString != "" {
                                tempString.append(", ")
                            }
                            tempString.append(name)
                        }
                    }
                }
                obj?.gendres = tempString
            }
        }
        
        return obj
    }
    
    public static func with(json: JSON) -> Movie? {
        return with(realm: try! Realm(), json: json)
    }
    
}
