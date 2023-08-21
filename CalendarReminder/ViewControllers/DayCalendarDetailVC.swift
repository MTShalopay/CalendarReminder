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
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = Helper.Color.Label.textBlackColor
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tabbarView: UIView = {
        let view = UIView()
        view.backgroundColor = Helper.Color.TabBar.textGreenDarkColor
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
        tableView.backgroundColor = Helper.Color.Label.textGreenDarkColor
        let bgView = UIView()
        bgView.backgroundColor = Helper.Color.Label.textGreenDarkColor
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
        let tapdissmis = UITapGestureRecognizer(target: self, action: #selector(dissmisPicker))
        view.addGestureRecognizer(tapdissmis)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        dateFormatter.dateFormat = "HH:mm"
        dateLabel.attributedText = NSAttributedString(string: "\(selectedDay.weekday), \(dateFormatter.string(from: date))")
    }
    
    private func setupView() {
        view.backgroundColor = Helper.Color.Label.textGreenDarkColor
        navigationController?.navigationBar.barTintColor = Helper.Color.Label.textGreenDarkColor
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Helper.Color.Label.textBlackColor]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: Helper.Color.Label.textBlackColor]
        self.navigationItem.title = "\(selectedDay.day) \(selectedDay.month.uppercased())"
        navigationController?.navigationBar.tintColor = Helper.Color.Label.textBlackColor
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "Calendar", style: .plain, target: nil, action: nil)
        view.addSubview(notesTableView)
        view.addSubview(emptyView)
        view.addSubview(tabbarView)
        view.addSubview(dateLabel)
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
    }
    
    @objc private func addEvent() {
        print(#function)
        selectedDay.notes.append(Note(text: ""))
        notesTableView.insertRows(at: [IndexPath(row: selectedDay.notes.count - 1, section: 0)], with: .automatic)
        let cell = notesTableView.cellForRow(at: IndexPath(row: selectedDay.notes.count - 1, section: 0)) as? NotesViewCell
        cell?.nameNotesTF.becomeFirstResponder()
        cell?.timerButton.setTitle("", for: .normal)
        cell?.timerButton.sizeToFit()
        emptyView.isHidden = true
    }
    @objc private func dissmisPicker() {
        notesTableView.endEditing(true)
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
        cell.configureCell(note, tag: indexPath.row)
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
