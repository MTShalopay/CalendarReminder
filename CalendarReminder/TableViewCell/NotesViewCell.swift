//
//  NotesViewCell.swift
//  CalendarReminder
//
//  Created by Shalopay on 18.08.2023.
//

import UIKit

class NotesViewCell: UITableViewCell {
    static let identifier = "NotesViewCell"
    
    private lazy var checkButton: UIButton = {
        let button = UIButton(type: .system)
        if let myImage = UIImage(systemName: "circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)) { button.setImage(myImage.withRenderingMode(.alwaysTemplate), for: .normal) }
        button.tintColor = Helper.Color.Label.textWhiteColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var nameNotesLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateNotesLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    public func configureCell(_ note: Note) {
        nameNotesLabel.attributedText = NSAttributedString(string: note.text, attributes: [NSAttributedString.Key.foregroundColor : Helper.Color.Label.textWhiteColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)])
        dateNotesLabel.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor : Helper.Color.Label.textWhiteColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
    }
    
    private func setupView() {
        contentView.backgroundColor = Helper.Color.ViewController.backGroundColorView
        contentView.addSubview(checkButton)
        contentView.addSubview(nameNotesLabel)
        contentView.addSubview(dateNotesLabel)
        NSLayoutConstraint.activate([
            checkButton.heightAnchor.constraint(equalToConstant: 30),
            checkButton.widthAnchor.constraint(equalToConstant: 30),
            checkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            nameNotesLabel.centerYAnchor.constraint(equalTo: checkButton.centerYAnchor),
            nameNotesLabel.leadingAnchor.constraint(equalTo: checkButton.trailingAnchor, constant: 10),
            nameNotesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            dateNotesLabel.topAnchor.constraint(equalTo: nameNotesLabel.bottomAnchor, constant: 10),
            dateNotesLabel.leadingAnchor.constraint(equalTo: checkButton.trailingAnchor, constant: 10),
            dateNotesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
