//
//  ViewController.swift
//  CollectionDemo
//
//  Created by shubam on 25/05/18.
//  Copyright © 2018 shubam. All rights reserved.
//

import UIKit
class Student{
    var className : String = ""
    var isSelected : Bool = false
    var studentNameList : [String] = []
    init(className : String, isSelected : Bool, studentNameList : [String]) {
        self.className = className
        self.isSelected = isSelected
        self.studentNameList = studentNameList
    }
}


class ViewController: UIViewController {
    
    var studentList : [Student] = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName:Constant.Identifers.headerTableViewCell, bundle: nil), forCellReuseIdentifier:Constant.Identifers.headerTableViewCell)
        
        tableView.register(UINib(nibName:Constant.Identifers.customTableViewCell, bundle: nil), forCellReuseIdentifier:Constant.Identifers.customTableViewCell)
        
        studentList = getStudentList()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func getStudentList()->[Student]{
        var students : [Student] = []
        for value in 1...10{
            students.append(Student(className: "Section\(value)", isSelected: false, studentNameList: ["Index 0","Index 1","Index 2","Index 3"]))
        }
        return students
    }
}

extension ViewController : UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return studentList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let student = studentList[section]
        if student.isSelected {
            return student.studentNameList.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifers.headerTableViewCell) as? HeaderTableViewCell else { return UITableViewCell() }
        let student = studentList[section]
        cell.delegate = self
        cell.configureCell(section: section, student: student)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifers.customTableViewCell) as? CustomTableViewCell else { return UITableViewCell() }
        let studentName = studentList[indexPath.section].studentNameList[indexPath.row]
        cell.label.text = studentName
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}

extension ViewController : HeaderViewDelegate{
    func expandButtonTapped(_ cell: HeaderTableViewCell) {
        let selectedStudent = self.studentList[cell.section ?? 0]
        for value in studentList{
            if value.className == selectedStudent.className{
                selectedStudent.isSelected = value.isSelected ? false : true
            } else {
                value.isSelected = false
            }
        }
        UIView.transition(with: tableView, duration: 0.50, options: .curveEaseIn, animations: { self.tableView.reloadData() })
    }
}


