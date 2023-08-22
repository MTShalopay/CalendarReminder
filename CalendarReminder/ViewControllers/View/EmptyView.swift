//
//  EmptyView.swift
//  CalendarReminder
//
//  Created by Shalopay on 18.08.2023.
//

import UIKit

class EmptyView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Set a reminder for today", attributes: [NSAttributedString.Key.foregroundColor : Theme.currentTheme.labelTextColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Theme.currentTheme.viewControllerBackgroundColor
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
