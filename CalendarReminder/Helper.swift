//
//  Helper.swift
//  CalendarReminder
//
//  Created by Shalopay on 17.08.2023.
//

import UIKit

class Helper {
    static var date = Date()
    static let numberOfLine: CGFloat = 5
    static var itemWidth: CGFloat = 0
    static var heightTabBar: CGFloat = 0
    static let calendar = Calendar(identifier: .gregorian)
    static var proportion: CGFloat = 10
    
    static let shared = Helper()
    private init() {}
    
    enum Color {
        enum ColorTheme {
            static var Theme1 = UIColor(hexRGB: "#556D5A") ?? UIColor()
            static var Theme2 = UIColor(hexRGB: "#A2A09C") ?? UIColor()
            static var Theme3 = UIColor(hexRGB: "#9D8570") ?? UIColor()
            static var Theme4 = UIColor(hexRGB: "#484A4E") ?? UIColor()
            enum ColorTheme1 {
                static var viewControllerBackgroundColor = UIColor(hexRGB: "#556D5A") ?? UIColor()
                static var tabBarControllerBackGroundColor = UIColor(hexRGB: "#485C4C") ?? UIColor()
                static var labelTextColor = UIColor(hexRGB: "#000000") ?? UIColor()
                static var cellViewContentBackgroundColor = UIColor(hexRGB: "#485C4C") ?? UIColor()
                static var cellText = UIColor(hexRGB: "#000000") ?? UIColor()
                static var currentLabelColor = UIColor(hexRGB: "#000000") ?? UIColor()
                static var cellCurrentDateColor = UIColor(hexRGB: "#FFFFFF") ?? UIColor()
            }
            
            enum ColorTheme2 {
                static var viewControllerBackgroundColor = UIColor(hexRGB: "#A2A09C") ?? UIColor()
                static var tabBarControllerBackGroundColor = UIColor(hexRGB: "#888683") ?? UIColor()
                static var labelTextColor = UIColor(hexRGB: "#000000") ?? UIColor()
                static var cellViewContentBackgroundColor = UIColor(hexRGB: "#888683") ?? UIColor()
                static var cellText = UIColor(hexRGB: "#000000") ?? UIColor()
                static var currentLabelColor = UIColor(hexRGB: "#000000") ?? UIColor()
                static var cellCurrentDateColor = UIColor(hexRGB: "#FFFFFF") ?? UIColor()
            }
            
            enum ColorTheme3 {
                static var viewControllerBackgroundColor = UIColor(hexRGB: "#9D8570") ?? UIColor()
                static var tabBarControllerBackGroundColor = UIColor(hexRGB: "#84705E") ?? UIColor()
                static var labelTextColor = UIColor(hexRGB: "#000000") ?? UIColor()
                static var cellViewContentBackgroundColor = UIColor(hexRGB: "#84705E") ?? UIColor()
                static var cellText = UIColor(hexRGB: "#000000") ?? UIColor()
                static var currentLabelColor = UIColor(hexRGB: "#000000") ?? UIColor()
                static var cellCurrentDateColor = UIColor(hexRGB: "#FFFFFF") ?? UIColor()
            }
            
            enum ColorTheme4 {
                static var viewControllerBackgroundColor = UIColor(hexRGB: "#484A4E") ?? UIColor()
                static var tabBarControllerBackGroundColor = UIColor(hexRGB: "#3C3E42") ?? UIColor()
                static var labelTextColor = UIColor(hexRGB: "#000000") ?? UIColor()
                static var cellViewContentBackgroundColor = UIColor(hexRGB: "#3C3E42") ?? UIColor()
                static var cellText = UIColor(hexRGB: "#000000") ?? UIColor()
                static var currentLabelColor = UIColor(hexRGB: "#000000") ?? UIColor()
                static var cellCurrentDateColor = UIColor(hexRGB: "#FFFFFF") ?? UIColor()
            }
        }
        enum TabBar {
            static var backGroundClear = UIColor.clear
            //let q  = UIColor(named: #colorLiteral(red: 0.2352941176, green: 0.2431372549, blue: 0.2588235294, alpha: 1))
        }
    }
}
