//
//  CalendarCell.swift
//  CalendarReminder
//
//  Created by Shalopay on 17.08.2023.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    static let identifier = "CalendarCell"
    
    public lazy var numberDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19)
        label.textColor = Helper.Color.Label.textWhiteColor
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    public func configureCell(day: Day) {
        numberDateLabel.attributedText = NSAttributedString(string: "\(day.day)")
    }
    
    private func setupView() {
        contentView.backgroundColor = Helper.Color.Label.textlightGreenColor
        contentView.layer.cornerRadius = Helper.cornerRadius
        contentView.addSubview(numberDateLabel)
        NSLayoutConstraint.activate([
            numberDateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            numberDateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
