//
//  Agenda.swift
//  Kongres PSSI
//
//  Created by Alam Akbar Muhammad on 09/01/18.
//  Copyright © 2018 suitmedia. All rights reserved.
//

import RealmSwift
import SwiftyJSON

class Agenda: Object {
    
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
        
//        if json["start_date"].exists() {
//            obj?.startDate = DateHelper.isoSuit(dateString: json["start_date"].stringValue)
//        }
//        
//        if json["end_date"].exists() {
//            obj?.endDate = DateHelper.isoSuit(dateString: json["end_date"].stringValue)
//        }
        
        return obj
    }
    
    public static func with(json: JSON) -> Agenda? {
        return with(realm: try! Realm(), json: json)
    }
    
}
