//
//  Helper.swift
//  CalendarReminder
//
//  Created by Shalopay on 17.08.2023.
//

import UIKit

class Helper {
    static let shared = Helper()
    static let numberOfLine: CGFloat = 5
    static var cornerRadius: CGFloat = 0
    static var heightTabBar: CGFloat = 0
    static let calendar = Calendar(identifier: .gregorian)
    private init() {}
    
    enum Color {
        enum ViewController {
            static var backGroundColorView = UIColor(hexRGB: "#15244e") ?? UIColor()
            static var backGroundClear = UIColor.clear
            enum Setting {
                static var textGreenDarkColor = UIColor(hexRGB: "#556D5A") ?? UIColor()
            }
        }
        enum Label {
            static var textOrangeColor = UIColor(hexRGB: "#F69707") ?? UIColor()
            static var textGreenColor = UIColor(hexRGB: "#02FF1A") ?? UIColor()
            static var textWhiteColor = UIColor(hexRGB: "#FFFFFF") ?? UIColor()
            static var textBlackColor = UIColor(hexRGB: "#000000") ?? UIColor()
            static var textGreenDarkColor = UIColor(hexRGB: "#556D5A") ?? UIColor()
            static var textlightGreenColor = UIColor(hexRGB: "#415344") ?? UIColor()
        }
        enum TabBar {
            static var textGreenDarkColor = UIColor(hexRGB: "#485C4C") ?? UIColor()
            //let q  = UIColor(named: #colorLiteral(red: 0.2823529412, green: 0.3607843137, blue: 0.2980392157, alpha: 1))
        }
    }
}
