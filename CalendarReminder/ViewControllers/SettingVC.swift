//
//  SettingVC.swift
//  CalendarReminder
//
//  Created by Shalopay on 17.08.2023.
//

import UIKit

class SettingVC: UIViewController {
    
    private lazy var titLabel: UILabel = {
       let label = UILabel()
        label.attributedText = NSAttributedString(string: "THEME")
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = Theme.currentTheme.cellCurrentDateColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 5
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 60, height: 60)
        return layout
    }()
    
    private lazy var themecollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ThemeCell.self, forCellWithReuseIdentifier: ThemeCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        title = "Settings"
//        tabBarController?.tabBar.barTintColor = Theme.currentTheme.viewControllerBackgroundColor
        view.backgroundColor = Theme.currentTheme.viewControllerBackgroundColor
        navigationController?.navigationBar.barTintColor = Theme.currentTheme.viewControllerBackgroundColor
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.currentTheme.cellCurrentDateColor]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.currentTheme.cellCurrentDateColor]
        view.addSubview(themecollectionView)
        view.addSubview(titLabel)
        NSLayoutConstraint.activate([
            titLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            titLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            titLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            themecollectionView.topAnchor.constraint(equalTo: titLabel.bottomAnchor),
            themecollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 0),
            themecollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 0),
            themecollectionView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
}

extension SettingVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Theme.ColorTheme.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemeCell.identifier, for: indexPath) as? ThemeCell else { return UICollectionViewCell(frame: .zero)}
        let colorTheme = Theme.ColorTheme.allCases[indexPath.row].colorView
        cell.configureCell(color: colorTheme)
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("IndexPathSection: \(indexPath.section) - IndexPathItem: \(indexPath.item)")
        guard let cell = collectionView.cellForItem(at: indexPath) as? ThemeCell else {return}
        switch indexPath.item {
        case 0:
            Theme.currentTheme = Theme.ThemeType.theme1.type
        case 1:
            Theme.currentTheme = Theme.ThemeType.theme2.type
        case 2:
            Theme.currentTheme = Theme.ThemeType.theme3.type
        case 3:
            Theme.currentTheme = Theme.ThemeType.theme4.type
        default:
            return Theme.currentTheme = Theme.ThemeType.theme1.type
        }
        cell.widthView.isHidden = false
        view.backgroundColor = Theme.currentTheme.tabBarControllerBackGroundColor
        tabBarController?.tabBar.barTintColor = Theme.currentTheme.viewControllerBackgroundColor
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ThemeCell else {return}
        cell.widthView.isHidden = true
    }
}
