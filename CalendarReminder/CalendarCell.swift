//
//  CalendarCell.swift
//  CalendarReminder
//
//  Created by Shalopay on 17.08.2023.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    static let identifier = "CalendarCell"
    
    let startAngle = -CGFloat.pi / 2
    let centre = CGPoint (x: Helper.itemWidth / 2, y: Helper.itemWidth / 2)
    let radius = Helper.itemWidth / 2
    
    
    public lazy var numberDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19)
        label.textColor = Theme.currentTheme.cellCurrentDateColor
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var roundView: UIView = {
        let roundView = UIView()
        roundView.layer.cornerRadius = Helper.itemWidth / 2
        let arc = CGFloat.pi * 2 * Helper.proportion / 100
        let cPath = UIBezierPath()
        cPath.move(to: centre)
        cPath.addLine(to: CGPoint(x: centre.x + radius * cos(startAngle), y: centre.y + radius * sin(startAngle)))
        cPath.addArc(withCenter: centre, radius: radius, startAngle: startAngle, endAngle: arc + startAngle, clockwise: true)
        cPath.addLine(to: CGPoint(x: centre.x, y: centre.y))
        let circleShape = CAShapeLayer()
        circleShape.path = cPath.cgPath
        circleShape.strokeColor = Theme.currentTheme.labelTextColor.cgColor
        circleShape.fillColor = Theme.currentTheme.labelTextColor.cgColor
        if arc == 0 {
            circleShape.lineWidth = 0
        } else {
            circleShape.lineWidth = 1.5
        }
        roundView.layer.addSublayer(circleShape)
        roundView.translatesAutoresizingMaskIntoConstraints = false
        return roundView
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
