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
        label.textColor = Helper.Color.Label.textWhiteColor
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
        view.backgroundColor = Helper.Color.ViewController.Setting.textGreenDarkColor
        navigationController?.navigationBar.barTintColor = Helper.Color.Label.textGreenDarkColor
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Helper.Color.Label.textWhiteColor]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: Helper.Color.Label.textWhiteColor]
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
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemeCell.identifier, for: indexPath) as? ThemeCell else { return UICollectionViewCell(frame: .zero)}
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("IndexPathSection: \(indexPath.section) - IndexPathItem: \(indexPath.item)")
    }
}
