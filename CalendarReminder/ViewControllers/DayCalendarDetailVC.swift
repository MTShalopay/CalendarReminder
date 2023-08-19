//
//  DayCalendarDetailVC.swift
//  CalendarReminder
//
//  Created by Shalopay on 17.08.2023.
//

import UIKit

class DayCalendarDetailVC: UIViewController {
    var date = Date()
    var dateFormatter = DateFormatter()
    var selectedDay: Day
    
    let emptyView = EmptyView()
    
    private var startTimes = [Date]()
    private var endTimes = [Date]()
    
    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: view.frame.size.height - 200, width: view.frame.size.width, height: 200))
        pickerView.backgroundColor = .white
        pickerView.dataSource = self
        pickerView.delegate = self
        return pickerView
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = Helper.Color.Label.textWhiteColor
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var customView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60))
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var timerButton: UIButton = {
        let button = UIButton(type: .system)
        if let myImage = UIImage(systemName: "clock", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)) { button.setImage(myImage.withRenderingMode(.alwaysTemplate), for: .normal) }
        button.tintColor = Helper.Color.Label.textWhiteColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addDateTime), for: .touchUpInside)
        return button
    }()
    
    private lazy var tabbarView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var addEvents: UIButton = {
        let button = UIButton(type: .system)
        if let myImage = UIImage(systemName: "plus.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)) { button.setImage(myImage.withRenderingMode(.alwaysTemplate), for: .normal) }
        button.tintColor = Helper.Color.Label.textWhiteColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addEvent), for: .touchUpInside)
        return button
    }()
    
    private lazy var notesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "default")
        tableView.register(NotesViewCell.self, forCellReuseIdentifier: NotesViewCell.identifier)
        tableView.backgroundColor = Helper.Color.ViewController.backGroundColorView
        let bgView = UIView()
        bgView.backgroundColor = Helper.Color.ViewController.backGroundColorView
        tableView.backgroundView = bgView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(detailDay: Day) {
        self.selectedDay = detailDay
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if selectedDay.notes.count == 0 {
            emptyView.isHidden = false
        }
        
        startTimes = getTimes()
        endTimes = getTimes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        dateFormatter.dateFormat = "HH:mm"
        dateLabel.attributedText = NSAttributedString(string: "\(selectedDay.weekday), \(dateFormatter.string(from: date))")
    }
    
    private func setupView() {
        view.backgroundColor = Helper.Color.ViewController.backGroundColorView
        navigationController?.navigationBar.barTintColor = Helper.Color.ViewController.backGroundColorView
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Helper.Color.Label.textWhiteColor]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: Helper.Color.Label.textWhiteColor]
        self.navigationItem.title = "\(selectedDay.day) \(selectedDay.month.uppercased())"
        navigationController?.navigationBar.tintColor = Helper.Color.Label.textWhiteColor
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "Calendar", style: .plain, target: nil, action: nil)
        view.addSubview(dateLabel)
        view.addSubview(notesTableView)
        view.addSubview(emptyView)
        view.addSubview(tabbarView)
        tabbarView.addSubview(addEvents)
        tabBarController?.tabBar.isHidden = true
        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            emptyView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            tabbarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabbarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabbarView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tabbarView.heightAnchor.constraint(equalToConstant: Helper.heightTabBar),
            
            notesTableView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            notesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            notesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            notesTableView.bottomAnchor.constraint(equalTo: tabbarView.topAnchor),
            
            addEvents.trailingAnchor.constraint(equalTo: tabbarView.trailingAnchor, constant: -15),
            addEvents.topAnchor.constraint(equalTo: tabbarView.topAnchor, constant: 10),
        ])
        
        customView.addSubview(timerButton)
        NSLayoutConstraint.activate([
            timerButton.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 10),
            timerButton.centerYAnchor.constraint(equalTo: customView.centerYAnchor),
        ])
    }
    
    @objc private func donedatePicker() {
        print(#function)
    }
    
    @objc private func addDateTime(sender: UIButton) {
        print(#function)
        view.addSubview(pickerView)
        pickerView.isHidden = false
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func addEvent() {
        print(#function)
        let alertController = UIAlertController(title: "Set a reminder for today", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Enter notes"
            textField.keyboardType = .default
            textField.becomeFirstResponder()
            textField.inputAccessoryView = self.customView
            textField.delegate = self
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            if let noteText = alertController.textFields?.first?.text, noteText.count > 0 {
                self.selectedDay.notes.append(Note(text: noteText))
                self.notesTableView.insertRows(at: [IndexPath(row: self.selectedDay.notes.count - 1, section: 0)], with: .automatic)
                self.emptyView.isHidden = true
            }
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func getTimes() -> [Date] {
        var times = [Date]()
        var currentDate = date
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
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension DayCalendarDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedDay.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotesViewCell.identifier, for: indexPath) as? NotesViewCell else {return UITableViewCell(frame: .zero)}
        let note = selectedDay.notes[indexPath.row]
        cell.configureCell(note)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            selectedDay.notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            if selectedDay.notes.count == 0 {
                emptyView.isHidden = false
            }
        }
    }
}

extension DayCalendarDetailVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        true
    }
}

extension DayCalendarDetailVC: UIPickerViewDelegate, UIPickerViewDataSource {
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
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return getTimeString(from: startTimes[row])
        case 1:
            return "to"
        case 2:
            return getTimeString(from: endTimes[row])
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let startTime = startTimes[pickerView.selectedRow(inComponent: 0)]
        let endTime = endTimes[pickerView.selectedRow(inComponent: 1)]
        print(getTimeString(from: startTime), getTimeString(from: endTime))
        pickerView.isHidden = true
        timerButton.setTitle("\(getTimeString(from: startTime)) to \(getTimeString(from: endTime))", for: .normal)
    }
}
