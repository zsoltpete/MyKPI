//
//  NewQuestionViewController.swift
//  MyKPI
//
//  Created by Zsolt Pete on 28/01/17.
//  Copyright © 2017 petez. All rights reserved.
//

import UIKit

class NewQuestionViewController: UITableViewController {

    var sendedQuestion: Question?
    var array: [Question] = [Question]()
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(sendedQuestion != nil){
            var indexPath = IndexPath(row: 0, section: 0)
            let cell: NewQuestionTitleCell = self.tableView.cellForRow(at: indexPath) as! NewQuestionTitleCell
            cell.inputTextField.text = sendedQuestion?.title
            
            indexPath = IndexPath(row: 1, section: 0)
            let cell2: NewQuestionTypeCell = self.tableView.cellForRow(at: indexPath) as! NewQuestionTypeCell
            cell2.acticeType = sendedQuestion?.type
        }
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func add(_ sender: Any) {
        var indexPath = IndexPath(row: 0, section: 0)
        let cell: NewQuestionTitleCell = self.tableView.cellForRow(at: indexPath) as! NewQuestionTitleCell
        let count = cell.inputTextField.text?.characters.count
        if(count != 0){
            
            if let decoded = UserDefaults.standard.object(forKey: "BaseQuestions") as? Data {
                array = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as! [Question]
                
            }
            indexPath = IndexPath(row: 1, section: 0)
            let cell2: NewQuestionTypeCell = self.tableView.cellForRow(at: indexPath) as! NewQuestionTypeCell
            indexPath = IndexPath(row: 2, section: 0)
            let cell3: BadSideCell = self.tableView.cellForRow(at: indexPath) as! BadSideCell
            let question = Question(title: cell.inputTextField.text!, type: cell2.acticeType!, lower: "\(cell3.segmentControl.selectedSegmentIndex)")
            
            // TODO: If editing
            /*
            if(sendedQuestion == nil){
                    array.append(question)
            }else{
                let position = self.searchForQuestionFrom(id: (sendedQuestion?.id)!)
                array[position] = question
            }*/
            
            
            array.append(question)
            UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: array), forKey: "BaseQuestions")
            UserDefaults.standard.synchronize()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.questions = array
            
            self.dismiss(animated: true, completion: nil)
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            let cell: NewQuestionTitleCell = tableView.dequeueReusableCell(withIdentifier:Constants.Cells.NewQuestionTitleCell, for: indexPath) as! NewQuestionTitleCell
            cell.titleLabel.text = "Kérdés:"
            
            return cell
        }else if(indexPath.row == 1){
            let cell: NewQuestionTypeCell = tableView.dequeueReusableCell(withIdentifier:Constants.Cells.NewQuestionTypeCell, for: indexPath) as! NewQuestionTypeCell
            cell.typeLabel.text = "Típus:"
            
            return cell
        }else{
            let cell: BadSideCell = tableView.dequeueReusableCell(withIdentifier:Constants.Cells.BadSideCell, for: indexPath) as! BadSideCell
            cell.titleLabel.text = "Hol legyen a alacsony szám?"
            
            return cell
        }
        
    }


    func searchForQuestionFrom(id: Int) -> Int{
        var counter = 0
        for question in self.array {
            if(question.id != id){
                counter = counter+1
            }else{
                break
            }
        }
        return counter
    }
}
