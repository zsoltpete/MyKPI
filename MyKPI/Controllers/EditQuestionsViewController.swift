//
//  EditQuestionsViewController.swift
//  MyKPI
//
//  Created by Zsolt Pete on 28/01/17.
//  Copyright © 2017 petez. All rights reserved.
//

import UIKit
import MGSwipeTableCell

class EditQuestionsViewController: UITableViewController, MGSwipeTableCellDelegate {
    
    var questions: [Question]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButton: UIButton = UIButton()
        let frame = CGRect(x: 0, y: 0, width: 20.0, height: 20.0)
        addButton.frame = frame
        addButton.setImage(UIImage(named: "close"), for: .normal)
        addButton.addTarget(self, action: #selector(addQuestion), for: .touchUpInside)
        let addButtonItem : UIBarButtonItem = UIBarButtonItem(customView: addButton)
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.setRightBarButton(addButtonItem, animated: true)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.questions = appDelegate.questions
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = self.questions?.count {
            return count
        }
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EditQuestionCell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.EditQuestionCell, for: indexPath) as! EditQuestionCell
        cell.questionTitleLabel.text = self.questions?[indexPath.row].title
        if(self.questions?[indexPath.row].type  == Constants.QuestionTypes.Feeling){
            cell.questionImageView.image = UIImage(named: "emoji")
        }else if(self.questions?[indexPath.row].type  == Constants.QuestionTypes.TrueFalse){
            cell.questionImageView.image = UIImage(named: "true_false")
        }else if(self.questions?[indexPath.row].type  == Constants.QuestionTypes.Point){
            cell.questionImageView.image = UIImage(named: "point")
        }else if(self.questions?[indexPath.row].type  == Constants.QuestionTypes.Time){
            cell.questionImageView.image = UIImage(named: "clock")
        }
        
        cell.rightButtons = [MGSwipeButton(title: "Delete", backgroundColor: UIColor.red)]
        cell.rightSwipeSettings.transition = MGSwipeTransition.rotate3D
        cell.delegate = self
        return cell
    }
    
    func addQuestion(){
        self.performSegue(withIdentifier: Constants.Segues.ShowAddQuestion, sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Constants.Segues.ShowAddQuestion, sender: questions?[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == Constants.Segues.ShowAddQuestion){
            if let sendQuestion: Question = sender as? Question {
                let newQuestionViewController: NewQuestionViewController = segue.destination as! NewQuestionViewController
                newQuestionViewController.sendedQuestion = sendQuestion
            }
        }
    }
    
    func swipeTableCell(_ cell: MGSwipeTableCell, tappedButtonAt index: Int, direction: MGSwipeDirection, fromExpansion: Bool) -> Bool {
        
        if (direction == .rightToLeft && index == 0) {
            let indexPath = self.tableView.indexPath(for: cell)
            self.tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath!], with: .fade)
            self.questions?.remove(at: (indexPath?.row)!)
            self.tableView.endUpdates()
            UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: self.questions), forKey: "BaseQuestions")
            UserDefaults.standard.synchronize()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.questions = self.questions
            
        }
        return true
    }
    
}
