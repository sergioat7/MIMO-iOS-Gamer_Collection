//
//  UIColor+Extension.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 13/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

struct Color {
    
    static let color1: UIColor = UIColor(hexString: "363636")!
    static let color1Light: UIColor = Color.color1.withAlphaComponent(Constants.Style.lightColor)
    static let color1SuperLight: UIColor = Color.color1.withAlphaComponent(Constants.Style.superLightColor)
    
    static let color2: UIColor = UIColor(hexString: "FFFFFF")!
    static let color2Light: UIColor = Color.color2.withAlphaComponent(Constants.Style.lightColor)
    static let color2SuperLight: UIColor = Color.color2.withAlphaComponent(Constants.Style.superLightColor)
    
    static let color3: UIColor = UIColor(hexString: "1ABC9C")!
    static let color3Light: UIColor = Color.color3.withAlphaComponent(Constants.Style.lightColor)
    static let color3SuperLight: UIColor = Color.color3.withAlphaComponent(Constants.Style.superLightColor)
    
    static let color4: UIColor = UIColor(hexString: "EC5565")!
    static let color4Light: UIColor = Color.color4.withAlphaComponent(Constants.Style.lightColor)
    static let color4SuperLight: UIColor = Color.color4.withAlphaComponent(Constants.Style.superLightColor)
    
    static let color5: UIColor = UIColor(hexString: "FECD54")!
    static let color5Light: UIColor = Color.color5.withAlphaComponent(Constants.Style.lightColor)
    static let color5SuperLight: UIColor = Color.color5.withAlphaComponent(Constants.Style.superLightColor)
}
