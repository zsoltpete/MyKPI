//
//  KPIItemsTableViewController.swift
//  MyKPI
//
//  Created by Zsolt Pete on 27/01/17.
//  Copyright © 2017 petez. All rights reserved.
//

import UIKit
import ActionCell
import MGSwipeTableCell

class KPIItemsTableViewController: UITableViewController, MGSwipeTableCellDelegate {
    
    var result: [String] = []
    var rows: Int = 0
    var questions: [Question]?
    var answerredQuestions: Int = 0
    var actualIndexPath = IndexPath()
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.questions = appDelegate.questions
        if let count = self.questions?.count {
            self.rows = count
        }
        NotificationCenter.default.addObserver(self, selector: #selector(addTimeAnswer), name: NSNotification.Name(rawValue: Constants.Events.AddTimeAnswerEvent), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(rows==0){
            self.navigationController?.popViewController(animated: false)
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: KPIQuestionCell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.KPIQuestionCell)! as! KPIQuestionCell
        /*let wrapper = ActionCell()
        wrapper.delegate = self
        cell.setUp(cell: cell, wrapper: wrapper, type: (self.questions?[indexPath.row].type)!)
        
        */
        if(self.questions?[indexPath.row].type != Constants.QuestionTypes.Time){
            cell.setUp(type:(self.questions?[indexPath.row].type)!, lower: (self.questions?[indexPath.row].lower)!)
        }else if (indexPath.row == 0){
            self.performSegue(withIdentifier: Constants.Segues.ShowTimerPicker, sender: self.questions?[indexPath.row].title)
        }
        

        cell.delegate = self
        
        cell.questionLabel.text = self.questions?[indexPath.row].title
        if(indexPath.row == 0){
            cell.isUserInteractionEnabled = true
        }
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == Constants.Segues.ShowResult){
            let resultViewController: ResultViewController = segue.destination as! ResultViewController
            let answers = self.result.joined(separator: ",")
            resultViewController.answers = answers
        }else if(segue.identifier == Constants.Segues.ShowTimerPicker){
            let timePickerViewController: TimePickerViewController = segue.destination as! TimePickerViewController
            timePickerViewController.question = sender as! String?
        }
    }
    func swipeTableCell(_ cell: MGSwipeTableCell, tappedButtonAt index: Int, direction: MGSwipeDirection, fromExpansion: Bool) -> Bool {

        let indexPath = self.tableView.indexPath(for: cell)
        if(direction == .rightToLeft){
            let modifiedIndex = 10-index
            result.append("\(modifiedIndex)")
        }else{
            result.append("\(index)")
        }
        
        rows=rows-1
        self.tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath!], with: .fade)
        self.tableView.endUpdates()
        
        self.questions?.remove(at: (indexPath?.row)!)
        answerredQuestions = answerredQuestions+1
        self.tableView.reloadData()
        if(rows == 0){
            
            self.performSegue(withIdentifier: Constants.Segues.ShowResult, sender:nil)
        }

        return true
    }
    
    func addTimeAnswer(notification: Notification){
        
        let time: String = notification.object as! String
        result.append("\(time)")
        rows=rows-1
        self.tableView.beginUpdates()
        tableView.deleteRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
        self.tableView.endUpdates()
        
        self.questions?.remove(at: 0)
        answerredQuestions = answerredQuestions+1
        self.tableView.reloadData()
        if(rows == 0){
            
            self.performSegue(withIdentifier: Constants.Segues.ShowResult, sender: nil)
        }
    }
    
}

