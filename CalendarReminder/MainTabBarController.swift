//
//  MainTabBarController.swift
//  CalendarReminder
//
//  Created by Shalopay on 17.08.2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    private enum TabBarItem: Int {
        case calendar
        case addEvent
        case setting
        var title: String {
            switch self {
            case .calendar:
                return "Calendar"
            case .addEvent:
                return ""
            case .setting:
                return "Settings"
            }
        }
        var iconName: String {
            switch self {
            case .calendar:
                return "calendar"
            case .addEvent:
                return "plus.square"
            case .setting:
            return "gear"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView(){
        UITabBar.appearance().tintColor = Theme.currentTheme.cellCurrentDateColor
        tabBar.barTintColor = Theme.currentTheme.tabBarControllerBackGroundColor
        let dataSource: [TabBarItem] = [.calendar, .addEvent, .setting]
        self.viewControllers = dataSource.map {
            switch $0 {
            case .calendar:
                let calendarVC = CalendarVC()
                return self.wrappedInNavigationController(with: calendarVC, title: $0.title, tag: 0)
            case .addEvent:
                let addEventVC = AddEventVC()
                return self.wrappedInNavigationController(with: addEventVC, title: $0.title, tag: 1)
            case .setting:
                let settingVC = SettingVC()
                return self.wrappedInNavigationController(with: settingVC, title: $0.title, tag: 2)
            }
        }
        self.viewControllers?.enumerated().forEach {
            $1.tabBarItem.title = dataSource[$0].title
            $1.tabBarItem.image = UIImage(systemName: dataSource[$0].iconName)
            $1.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: .zero, bottom: -5, right: .zero)
        }
    }
    
    private func wrappedInNavigationController(with: UIViewController, title: Any?, tag: Int) -> UINavigationController {
            return UINavigationController(rootViewController: with)
    }
}
