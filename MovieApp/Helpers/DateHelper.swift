//
//  DateHelper.swift
//  MovieAppCore
//
//  Created by Rifat Firdaus on 11/21/16.
//  Copyright © 2016 Suitmedia. All rights reserved.
//

import UIKit

open class DateHelper: NSObject {

    public static func isoSuit(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return dateFormatter.date(from: dateString)
    }
    
    public static func iso8601(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "id_ID")
        dateFormatter.timeZone = NSTimeZone.local
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.dateFormat = "MMM dd yyyy HH:mm:ss:SSSa"
        return dateFormatter.date(from: dateString)
    }
    
    public static func iso8601(date: Date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "id_ID")
        dateFormatter.timeZone = NSTimeZone.local
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        //        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.dateFormat = "MMM dd yyyy HH:mm:ss:SSSa"
        return dateFormatter.string(from: date)
    }
    
    public static func date(_ dateString: String, withFormatString formatString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatString
        return dateFormatter.date(from: dateString)
    }
    
}
