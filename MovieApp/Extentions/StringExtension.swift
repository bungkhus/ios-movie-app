//
//  StringExtension.swift
//  Soundrenaline
//
//  Created by Muhammad Alam A. on 4/25/17.
//  Copyright © 2017 Suitmedia. All rights reserved.
//

import Foundation

extension String {
    
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8),
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    
    var html2String: String? {
        return html2AttributedString?.string
    }
    
}
