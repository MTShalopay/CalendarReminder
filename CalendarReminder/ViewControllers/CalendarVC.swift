//
//  CalendarVC.swift
//  CalendarReminder
//
//  Created by Shalopay on 17.08.2023.
//

import UIKit

class CalendarVC: UIViewController {
    let dateFormatter = DateFormatter()
    let date = Date()
    var monthDays = [Day]()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = Helper.Color.Label.textWhiteColor
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 5
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CalendarCell.self, forCellWithReuseIdentifier: CalendarCell.identifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "defaultcell")
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        Helper.heightTabBar = tabBarController?.tabBar.frame.size.height ?? 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dateFormatter.dateFormat = "EEEE, HH:mm"
        dateLabel.attributedText = NSAttributedString(string: "\(dateFormatter.string(from: date))")
        tabBarController?.tabBar.isHidden = false
        setupView()
        monthDays = getDaysOfMonth(for: date)
    }
    
    private func setupView() {
        view.backgroundColor = Helper.Color.ViewController.backGroundColorView
        navigationController?.navigationBar.barTintColor = Helper.Color.ViewController.backGroundColorView
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Helper.Color.Label.textWhiteColor]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: Helper.Color.Label.textWhiteColor]
        
        dateFormatter.dateFormat = "dd MMMM"
        self.navigationItem.title = "\(dateFormatter.string(from: date).uppercased())"
        
        view.addSubview(dateLabel)
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            collectionView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func getDaysOfMonth(for baseDate: Date) -> [Day]{
         var tempDayArray = [Day]()
         guard let dayRange = Helper.calendar.range(of: .day, in: .month, for: baseDate) else {return tempDayArray}
         var components = Helper.calendar.dateComponents([.day, .month, .year], from: baseDate)
         let componentsForWholeMonth = dayRange.compactMap({ day -> DateComponents? in
             components.day = day
             return Helper.calendar.date(from: components).flatMap { Helper.calendar.dateComponents([.weekday, .day, .month, .year], from: $0)}
         })
         
         for components in componentsForWholeMonth {
             guard let weekday = components.weekday, let day = components.day, let month = components.month, let year = components.year else { return tempDayArray}
            if let weekday = WeekDay(rawValue: weekday)?.name, let month = Month(rawValue: month)?.name {
                 tempDayArray.append(Day(weekday: weekday, day: day, month: month, year: year))
             }
             //print(components.weekday!, components.day!, components.month!, components.year!)
         }
         return tempDayArray
     }
}

extension CalendarVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return monthDays.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCell.identifier, for: indexPath) as? CalendarCell else { return UICollectionViewCell(frame: .zero)}
        let day = monthDays[indexPath.row]
        cell.configureCell(day: day)
        if day.day == Helper.calendar.component(.day, from: date) {
            cell.contentView.backgroundColor = Helper.Color.Label.textWhiteColor
            cell.numberDateLabel.textColor = Helper.Color.Label.textOrangeColor
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        let day = monthDays[indexPath.row]
        let dayCalendarDetailVC = DayCalendarDetailVC(detailDay: day)
        navigationController?.pushViewController(dayCalendarDetailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0
        let insets = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
        let needed = collectionView.frame.width - (Helper.numberOfLine - 1) * spacing - insets.left - insets.right
        let itemwidth = floor(needed / Helper.numberOfLine)
        Helper.cornerRadius = itemwidth / 2
        return CGSize(width: itemwidth, height: itemwidth)
    }
}
