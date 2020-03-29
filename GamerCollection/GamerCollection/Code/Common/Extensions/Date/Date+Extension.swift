//
//  Date+Extension.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 28/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation

extension Date {

    func toString(format: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.locale = Locale(identifier: Locale.current.languageCode ?? "en")
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
