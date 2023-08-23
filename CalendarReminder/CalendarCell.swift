//
//  CalendarCell.swift
//  CalendarReminder
//
//  Created by Shalopay on 17.08.2023.
//

import UIKit
import SwiftUI

class CalendarCell: UICollectionViewCell {
    static let identifier = "CalendarCell"
    var waveUIView = WaveUIView(percent: 40.0)
    
    private lazy var roundView: UIView = {
        let view = UIView()
        var controller = UIHostingController(rootView: waveUIView)
        controller.view.layer.cornerRadius = Helper.itemWidth / 2
        controller.view.backgroundColor = .clear
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(controller.view)
        controller.view.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        controller.view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        controller.view.heightAnchor.constraint(equalToConstant: Helper.itemWidth).isActive = true
        controller.view.widthAnchor.constraint(equalToConstant: Helper.itemWidth).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public lazy var numberDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19)
        label.textColor = Theme.currentTheme.cellCurrentDateColor
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    public func configureCell(day: Day, color: UIColor) {
        numberDateLabel.attributedText = NSAttributedString(string: "\(day.day)")
        contentView.backgroundColor = Theme.currentTheme.cellViewContentBackgroundColor
    }
    
    private func setupView() {
        contentView.layer.cornerRadius = Helper.itemWidth / 2
        contentView.addSubview(roundView)
        contentView.addSubview(numberDateLabel)
        NSLayoutConstraint.activate([
            numberDateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            numberDateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            roundView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            roundView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            roundView.heightAnchor.constraint(equalToConstant: Helper.itemWidth),
            roundView.widthAnchor.constraint(equalToConstant: Helper.itemWidth),
        ])
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
