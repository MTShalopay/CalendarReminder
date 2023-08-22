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
        view.clipsToBounds = true
        view.layer.cornerRadius = 30
        view.layer.borderWidth = 2
        view.layer.borderColor = Theme.currentTheme.labelTextColor.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public lazy var widthView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 25
        view.layer.borderWidth = 2
        view.layer.borderColor = Theme.currentTheme.labelTextColor.cgColor
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    public func configureCell(color : UIColor) {
        themeView.backgroundColor = color
    }
    
    private func setupView() {
        contentView.addSubview(themeView)
        themeView.addSubview(widthView)
        NSLayoutConstraint.activate([
            themeView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            themeView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            themeView.heightAnchor.constraint(equalToConstant: 60),
            themeView.widthAnchor.constraint(equalToConstant: 60),
            
            widthView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            widthView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            widthView.heightAnchor.constraint(equalToConstant: 50),
            widthView.widthAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
