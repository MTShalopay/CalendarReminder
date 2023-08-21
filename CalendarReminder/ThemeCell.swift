//
//  ThemeCell.swift
//  CalendarReminder
//
//  Created by Shalopay on 21.08.2023.
//

import UIKit

class ThemeCell: UICollectionViewCell {
    static let identifier = "ThemeCell"
    
    private lazy var themeView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.clipsToBounds = true
        view.layer.cornerRadius = 30
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView() {
        contentView.addSubview(themeView)
        NSLayoutConstraint.activate([
            themeView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            themeView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            themeView.heightAnchor.constraint(equalToConstant: 60),
            themeView.widthAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
