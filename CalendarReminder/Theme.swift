//
//  Theme.swift
//  CalendarReminder
//
//  Created by Shalopay on 21.08.2023.
//

import UIKit

protocol ThemeProtocol: AnyObject {
    var viewControllerBackgroundColor : UIColor { get }
    var tabBarControllerBackGroundColor: UIColor { get }
    var labelTextColor: UIColor { get }
    var cellViewContentBackgroundColor: UIColor { get }
    var cellText: UIColor { get }
    var currentLabelColor: UIColor { get }
    var cellCurrentDateColor: UIColor { get }
}

class Theme {
    enum ColorTheme: Int, CaseIterable {
        case theme1
        case theme2
        case theme3
        case theme4
        var colorView: UIColor {
            switch self {
            case .theme1:
                return Helper.Color.ColorTheme.Theme1
            case .theme2:
                return Helper.Color.ColorTheme.Theme2
            case .theme3:
                return Helper.Color.ColorTheme.Theme3
            case .theme4:
                return Helper.Color.ColorTheme.Theme4
            }
        }
    }
    
    enum ThemeType {
        case theme1
        case theme2
        case theme3
        case theme4
        var type: ThemeProtocol {
            switch self {
            case .theme1:
                return CurrentTheme(viewControllerBackgroundColor: Helper.Color.ColorTheme.ColorTheme1.viewControllerBackgroundColor,
                                    tabBarControllerBackGroundColor: Helper.Color.ColorTheme.ColorTheme1.tabBarControllerBackGroundColor,
                                    labelTextColor: Helper.Color.ColorTheme.ColorTheme1.labelTextColor,
                                    cellViewContentBackgroundColor: Helper.Color.ColorTheme.ColorTheme1.cellViewContentBackgroundColor,
                                    cellText: Helper.Color.ColorTheme.ColorTheme1.cellText,
                                    currentLabelColor: Helper.Color.ColorTheme.ColorTheme1.currentLabelColor,
                                    cellCurrentDateColor: Helper.Color.ColorTheme.ColorTheme1.cellCurrentDateColor)
            case .theme2:
                return CurrentTheme(viewControllerBackgroundColor: Helper.Color.ColorTheme.ColorTheme2.viewControllerBackgroundColor,
                                    tabBarControllerBackGroundColor: Helper.Color.ColorTheme.ColorTheme2.tabBarControllerBackGroundColor,
                                    labelTextColor: Helper.Color.ColorTheme.ColorTheme2.labelTextColor,
                                    cellViewContentBackgroundColor: Helper.Color.ColorTheme.ColorTheme2.cellViewContentBackgroundColor,
                                    cellText: Helper.Color.ColorTheme.ColorTheme2.cellText,
                                    currentLabelColor: Helper.Color.ColorTheme.ColorTheme2.currentLabelColor,
                                    cellCurrentDateColor: Helper.Color.ColorTheme.ColorTheme2.cellCurrentDateColor)
            case .theme3:
                return CurrentTheme(viewControllerBackgroundColor: Helper.Color.ColorTheme.ColorTheme3.viewControllerBackgroundColor,
                                    tabBarControllerBackGroundColor: Helper.Color.ColorTheme.ColorTheme3.tabBarControllerBackGroundColor,
                                    labelTextColor: Helper.Color.ColorTheme.ColorTheme3.labelTextColor,
                                    cellViewContentBackgroundColor: Helper.Color.ColorTheme.ColorTheme3.cellViewContentBackgroundColor,
                                    cellText: Helper.Color.ColorTheme.ColorTheme3.cellText,
                                    currentLabelColor: Helper.Color.ColorTheme.ColorTheme3.currentLabelColor,
                                    cellCurrentDateColor: Helper.Color.ColorTheme.ColorTheme3.cellCurrentDateColor)
            case .theme4:
                return CurrentTheme(viewControllerBackgroundColor: Helper.Color.ColorTheme.ColorTheme4.viewControllerBackgroundColor,
                                    tabBarControllerBackGroundColor: Helper.Color.ColorTheme.ColorTheme4.tabBarControllerBackGroundColor,
                                    labelTextColor: Helper.Color.ColorTheme.ColorTheme4.labelTextColor,
                                    cellViewContentBackgroundColor: Helper.Color.ColorTheme.ColorTheme4.cellViewContentBackgroundColor,
                                    cellText: Helper.Color.ColorTheme.ColorTheme4.cellText,
                                    currentLabelColor: Helper.Color.ColorTheme.ColorTheme4.currentLabelColor,
                                    cellCurrentDateColor: Helper.Color.ColorTheme.ColorTheme4.cellCurrentDateColor)
            }
        }
    }
    
    static var currentTheme: ThemeProtocol = CurrentTheme(viewControllerBackgroundColor: Helper.Color.ColorTheme.ColorTheme1.viewControllerBackgroundColor,
                                                          tabBarControllerBackGroundColor: Helper.Color.ColorTheme.ColorTheme1.tabBarControllerBackGroundColor,
                                                          labelTextColor: Helper.Color.ColorTheme.ColorTheme1.labelTextColor,
                                                          cellViewContentBackgroundColor: Helper.Color.ColorTheme.ColorTheme1.cellViewContentBackgroundColor,
                                                          cellText: Helper.Color.ColorTheme.ColorTheme1.cellText,
                                                          currentLabelColor: Helper.Color.ColorTheme.ColorTheme1.currentLabelColor,
                                                          cellCurrentDateColor: Helper.Color.ColorTheme.ColorTheme1.cellCurrentDateColor)
}
