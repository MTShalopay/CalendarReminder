//
//  CurrentTheme.swift
//  CalendarReminder
//
//  Created by Shalopay on 21.08.2023.
//

import UIKit

class CurrentTheme: ThemeProtocol {
    internal var viewControllerBackgroundColor: UIColor
    internal var tabBarControllerBackGroundColor: UIColor
    internal var labelTextColor: UIColor
    internal var cellViewContentBackgroundColor: UIColor
    internal var cellText: UIColor
    internal var currentLabelColor: UIColor
    internal var cellCurrentDateColor: UIColor
    
    init(viewControllerBackgroundColor: UIColor, tabBarControllerBackGroundColor: UIColor, labelTextColor: UIColor, cellViewContentBackgroundColor: UIColor, cellText: UIColor, currentLabelColor : UIColor, cellCurrentDateColor: UIColor) {
        self.viewControllerBackgroundColor = viewControllerBackgroundColor
        self.tabBarControllerBackGroundColor = tabBarControllerBackGroundColor
        self.labelTextColor = labelTextColor
        self.cellViewContentBackgroundColor = cellViewContentBackgroundColor
        self.cellText = cellText
        self.currentLabelColor = currentLabelColor
        self.cellCurrentDateColor = cellCurrentDateColor
    }
}
