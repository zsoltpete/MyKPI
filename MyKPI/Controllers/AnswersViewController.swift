//
//  AnswersViewController.swift
//  MyKPI
//
//  Created by Zsolt Pete on 31/01/17.
//  Copyright © 2017 petez. All rights reserved.
//

import UIKit

class AnswersViewController: UITableViewController {

    var counter: Int?
    var questions: [Question]?
    var results: [Result]?
    var answerElements: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.flatSkyBlue
    }

    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.questions = appDelegate.questions
        
        
        if let decoded = UserDefaults.standard.object(forKey: "Results") as? Data {
            self.results = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as! [Result]
        }
        let actualAnswer = self.results?[counter!].answers
        self.answerElements = actualAnswer?.components(separatedBy: ",")
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
        let cell: AnswersCell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.AnswersCell, for: indexPath) as! AnswersCell

        cell.titleLabel.text = self.questions?[indexPath.row].title
        cell.answerLabel.text = answerElements?[indexPath.row]
        return cell
    }
 

}
