//
//  YearCollectionViewCell2.swift
//  PixelYear
//
//  Created by Елизавета on 01.09.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import UIKit

class YearCollectionViewCell: UICollectionViewCell {
    let scrollView = UIScrollView()
    var year: Year?
    var tableView = UITableView()
    var selectedItem = DayView()
    var dayLabelIndexPath: IndexPath?
    var color = ["0", "6", "5", "4", "3", "2", "1"]
    var option = ["Нет данных", "Отличный", "Хороший", "Обычный", "Плохой", "Болею", "Устал"]

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureScrollView()
        createDays()
        tableView.isScrollEnabled = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureScrollView() {
        contentView.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        scrollView.showsVerticalScrollIndicator = false
    }

    func createDays() {
        for _ in 0...30 {
            for _ in 0...11 {
                let day = DayView()
                day.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
                scrollView.addSubview(day)
            }
        }
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if let tapped = sender.view {
            selectedItem = tapped as! DayView
            let components = selectedItem.day?.date.get(.day, .month, .year)
            let day = components?.day
            let month = components?.month
            let year = components?.year
            let dayString = "\(day ?? -1).\(month ?? -1).\(year ?? -1)"
            if(dayLabelIndexPath != nil) {
                let firstCell = tableView.cellForRow(at: dayLabelIndexPath!) as? CustomTableViewCell
                firstCell?.dateLabel.text = dayString
            }
            let window = UIApplication.shared.keyWindow
            let screenSize = UIScreen.main.bounds.size
            tableView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 250)
            window?.addSubview(tableView)
            tableViewAnimation(with: screenSize.height - 250 - 180)
        }
    }

    func setSize() {
        guard let year = year else { return }
        let margin = 3
        let widt = (Int(self.frame.width) - margin) / 12
        var count = 0
        for i in 0...year.months.count - 1 {
            let cow = year.months[i].count - 1
            for j in 0...cow {
                let day = scrollView.subviews[count] as! DayView
                day.setDay(day: year.months[i][j])
                day.frame = CGRect(x: i * widt + margin, y: j * widt + margin, width: widt - margin, height: widt - margin)
                let yearDay = year.months[i][j]
                day.layer.backgroundColor = UIColor(named: yearDay.status)?.cgColor
                count += 1
            }
        }
        scrollView.contentSize = CGSize(width: self.frame.width, height: CGFloat(widt) * 31 + CGFloat(margin))
    }

    func setYear(year: Year) {
        self.year = year
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = UIColor.clear
    }

    func tableViewAnimation(with y: CGFloat) {
        let screenSize = UIScreen.main.bounds.size
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0,
            options: .curveEaseInOut, animations: {
                self.tableView.frame = CGRect(x: 0, y: y, width: screenSize.width, height: 500)
            })
    }

}

extension YearCollectionViewCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return color.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CustomTableViewCell else {
            fatalError("Unable to deque cell")
        }
        if indexPath.row == 0 {
            dayLabelIndexPath = indexPath
            if let date = selectedItem.day?.date {
                cell.dateLabel.text = getDateString(for: date)
            }
            cell.dateLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        } else {
            cell.dateLabel.text = option[indexPath.row - 1]
            let view = UIView()
            view.backgroundColor = UIColor.init(named: color[indexPath.row - 1])
            view.frame = CGRect(x: 15, y: 10, width: 27, height: 27)
            view.layer.cornerRadius = 2
            cell.addSubview(view)
        }
        return cell
    }

    func getDateString(for date: Date) -> String {
        let components = date.get(.day, .month, .year)
        let day = components.day
        let month = components.month
        let year = components.year
        return "\(day!).\(month!).\(year!)"
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = selectedItem
        if indexPath.row != 0 {
            cell.backgroundColor = UIColor.init(named: color[indexPath.row - 1])
        }
        let screenSize = UIScreen.main.bounds.size
        tableViewAnimation(with: screenSize.height)
        tableView.cellForRow(at: indexPath)?.selectionStyle = .none
    }

}
