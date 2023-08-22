//
//  NotesViewCell.swift
//  CalendarReminder
//
//  Created by Shalopay on 18.08.2023.
//

import UIKit

class NotesViewCell: UITableViewCell {
    static let identifier = "NotesViewCell"
    
    private var startTimes = [Date]()
    private var endTimes = [Date]()
    
    public lazy var timerButton: UIButton = {
        let button = UIButton(type: .system)
        if let myImage = UIImage(systemName: "clock", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)) { button.setImage(myImage.withRenderingMode(.alwaysTemplate), for: .normal)
            button.tintColor = Theme.currentTheme.labelTextColor
            button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            button.backgroundColor = Theme.currentTheme.cellViewContentBackgroundColor
            button.clipsToBounds = true
            button.layer.cornerRadius = 25
            button.addTarget(self, action: #selector(enteredTime), for: .touchUpInside)
        }
        return button
    }()
    
    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.backgroundColor = Theme.currentTheme.labelTextColor
        pickerView.sizeToFit()
        return pickerView
    }()
    
    private lazy var toolBar: UIToolbar = {
        let toolBar = UIToolbar()
        let leftButton = UIBarButtonItem(customView: timerButton)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([leftButton, spaceButton], animated: true)
        toolBar.clipsToBounds = true
        toolBar.backgroundColor = Helper.Color.TabBar.backGroundClear
        toolBar.setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
        toolBar.sizeToFit()
        return toolBar
    }()
    
    private lazy var checkButton: UIButton = {
        let button = UIButton(type: .system)
        if let myImage = UIImage(systemName: "circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)) { button.setImage(myImage.withRenderingMode(.alwaysTemplate), for: .normal) }
        button.tintColor = Theme.currentTheme.labelTextColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public lazy var nameNotesTF: UITextField = {
        let textField = UITextField()
        textField.textColor = Theme.currentTheme.labelTextColor
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.delegate = self
        textField.inputAccessoryView = toolBar
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
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
        startTimes = getTimes()
        endTimes = getTimes()
    }
    
    public func configureCell(_ note: Note, tag: Int) {
        //nameNotesLabel.attributedText = NSAttributedString(string: note.text, attributes: [NSAttributedString.Key.foregroundColor : Helper.Color.Label.textBlackColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)])
        nameNotesTF.attributedText = NSAttributedString(string: note.text)
        nameNotesTF.tag = tag
        dateNotesLabel.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor : Theme.currentTheme.labelTextColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)])
    }
    
    private func setupView() {
        contentView.backgroundColor = Theme.currentTheme.viewControllerBackgroundColor
        contentView.addSubview(checkButton)
        contentView.addSubview(nameNotesTF)
        contentView.addSubview(dateNotesLabel)
        NSLayoutConstraint.activate([
            checkButton.heightAnchor.constraint(equalToConstant: 30),
            checkButton.widthAnchor.constraint(equalToConstant: 30),
            checkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                        
            nameNotesTF.centerYAnchor.constraint(equalTo: checkButton.centerYAnchor),
            nameNotesTF.leadingAnchor.constraint(equalTo: checkButton.trailingAnchor, constant: 10),
            nameNotesTF.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            dateNotesLabel.topAnchor.constraint(equalTo: nameNotesTF.bottomAnchor),
            dateNotesLabel.leadingAnchor.constraint(equalTo: checkButton.trailingAnchor, constant: 10),
            dateNotesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
    }
    
    private func getTimes() -> [Date] {
        var times = [Date]()
        var currentDate = Date()
        currentDate = Helper.calendar.date(bySetting: .hour, value: 7, of: currentDate)!
        currentDate = Helper.calendar.date(bySetting: .minute, value: 00, of: currentDate)!
        let interval = 5
        var nextDiff = interval - Helper.calendar.component(.minute, from: currentDate) % interval
        var nextDate = Helper.calendar.date(byAdding: .minute, value: nextDiff, to: currentDate) ?? Date()
        var hour = Helper.calendar.component(.hour, from: nextDate)
        while(hour < 23) {
          times.append(nextDate)
            nextDiff = interval - Helper.calendar.component(.minute, from: nextDate) % interval
            nextDate = Helper.calendar.date(byAdding: .minute, value: nextDiff, to: nextDate) ?? Date()
            hour = Helper.calendar.component(.hour, from: nextDate)
        }
        return times
      }
      
      private func getTimeString(from: Date) -> String {
        let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "h:mm a"
        return timeFormatter.string(from: from)
      }
    
    @objc private func enteredTime(sender: UIButton) {
        nameNotesTF.resignFirstResponder()
        nameNotesTF.inputView = pickerView
        let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonItem))
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonItem))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let titleLabel = UILabel()
        titleLabel.text = "Time"
        titleLabel.textColor = Theme.currentTheme.cellCurrentDateColor
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        let customView = UIBarButtonItem(customView: titleLabel)
        toolBar.backgroundColor = Theme.currentTheme.labelTextColor
        toolBar.setItems([cancel, spaceButton, customView, spaceButton, done], animated: true)
        nameNotesTF.becomeFirstResponder()
    }
    
    @objc private func cancelButtonItem() {
        print(#function)
        setupNewToolBar()
    }
    
    @objc private func doneButtonItem() {
        print(#function)
        setupNewToolBar()
    }
    
    private func setupNewToolBar() {
        nameNotesTF.resignFirstResponder()
        nameNotesTF.inputView = nil
        let leftButton = UIBarButtonItem(customView: timerButton)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([leftButton, spaceButton], animated: true)
        toolBar.backgroundColor = Helper.Color.TabBar.backGroundClear
        toolBar.setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension NotesViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        contentView.endEditing(true)
        return true
    }
}

extension NotesViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return startTimes.count
        case 1:
            return 1
        case 2:
            return endTimes.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
            return pickerView.frame.size.width/3
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        switch component {
        case 0:
            return NSAttributedString(string: getTimeString(from: startTimes[row]), attributes: [NSAttributedString.Key.foregroundColor : Theme.currentTheme.cellCurrentDateColor])
        case 1:
            return NSAttributedString(string: "to", attributes: [NSAttributedString.Key.foregroundColor : Theme.currentTheme.cellCurrentDateColor])
        case 2:
            return NSAttributedString(string: getTimeString(from: endTimes[row]), attributes: [NSAttributedString.Key.foregroundColor : Theme.currentTheme.cellCurrentDateColor])
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return getTimeString(from: startTimes[row])
        case 1:
            return "to"
        case 2:
            return getTimeString(from: endTimes[row])
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(getTimeString(from: startTimes[pickerView.selectedRow(inComponent: 0)]), getTimeString(from: endTimes[pickerView.selectedRow(inComponent: 2)]))
        dateNotesLabel.attributedText = NSAttributedString(string: "\(getTimeString(from: startTimes[pickerView.selectedRow(inComponent: 0)])) to \(getTimeString(from: endTimes[pickerView.selectedRow(inComponent: 2)]))")
        
        self.timerButton.setTitle("\(self.getTimeString(from: self.startTimes[pickerView.selectedRow(inComponent: 0)])) to \(self.getTimeString(from: self.endTimes[pickerView.selectedRow(inComponent: 2)]))", for: .normal)
        self.timerButton.sizeToFit()
        nameNotesTF.inputView = nil
    }
}

