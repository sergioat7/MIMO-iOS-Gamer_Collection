//
//  String+Extension.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 28/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation

extension String {

    func toDate(format: String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.locale = Locale(identifier: Locale.current.languageCode ?? "en")
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
}
