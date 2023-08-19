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
        label.attributedText = NSAttributedString(string: "Set a reminder for today", attributes: [NSAttributedString.Key.foregroundColor : Helper.Color.Label.textWhiteColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25)])
        label.textColor = Helper.Color.Label.textWhiteColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
