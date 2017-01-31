////
//  HomeViewController.swift
//  MyKPI
//
//  Created by Zsolt Pete on 28/01/17.
//  Copyright © 2017 petez. All rights reserved.
//

import UIKit
import MGSwipeTableCell

class HomeViewController: UITableViewController, ShareProtocol,  FSCalendarDataSource, FSCalendarDelegate, MGSwipeTableCellDelegate{

    
    
    @IBOutlet weak var startButton: UIButton!
    
    
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var calendarView: FSCalendar!
    
    var resultDates: [String]?
    var matrixOfDates: [[Result]] = [[]]
    var results: [Result]? = [Result]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if let decoded = UserDefaults.standard.object(forKey: "BaseQuestions") as? Data {
            let array = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as! [Question]
            
            appDelegate.questions = array
        }

        calendarView.setScope(.week, animated: true)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        calendarView.setCurrentPage(Date(), animated: true)
        if let decoded = UserDefaults.standard.object(forKey: "Results") as? Data {
            let array = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as! [Result]
            
            self.results = array
        }
        
        if self.results != nil {
            /*var array: [String]? = [String]()
            for result: Result in self.results! {
                array?.append(result.date)
            }*/
            if ((self.results?.count) != 0){
                self.matrixOfDates = self.convertToMatrix(results: self.results!)
                self.tableView.reloadData()
            }
            
        }
        
        if(getDayInString() == self.results?.last?.date){
            self.startButton.isEnabled = false
            // TODO: Change label on Button to: Show Results
        }else{
            self.startButton.isEnabled = true
        }
        
    }
    
    @IBAction func startKPI(_ sender: Any) {
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if self.results?.count != 0 {
            return self.matrixOfDates.count
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.results?.count) != 0 {
            return matrixOfDates[section].count
        }
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.results?.count == 0  {
            return UITableViewCell()
        }
        
        let cell: HistoryItemCell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.HistoryItemCell, for: indexPath) as! HistoryItemCell
        
        let resultArray: [Result] = self.matrixOfDates[indexPath.section]
        let result: Result = resultArray[indexPath.row]
        cell.textLabel?.text = result.date
        
        cell.rightButtons = [MGSwipeButton(title: "Delete", backgroundColor: UIColor.red)]
        cell.rightSwipeSettings.transition = MGSwipeTransition.rotate3D
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if self.results?.count == 0 {
            return UITableViewCell()
        }
        let cell: HistorySectionHeaderCell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.HistorySectionHeaderCell) as! HistorySectionHeaderCell

        cell.titleLabel.text = "\((self.matrixOfDates[section][0]).date)."
        cell.shareButton.section = section
        cell.shareButton.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func convertToMatrix(results: [Result]) -> [[Result]]{
        var matrix = [[Result]]()
        var tmp = [Result]()
        var i=0
        var j=0
        for result: Result in results {
            let day = getDayOfWeek(today: result.date)
            if day == 2 {
                matrix.append(tmp)
                tmp.removeAll()
                tmp.append(result)
                i=i+1
                j=0
            }else{
                tmp.append(result)
            }
            
            j=j+1
        }
        matrix.append(tmp)
        return matrix
    }
    
    func convertToVector(matrix: [[Result]]) -> [Result]{
        var vector = [Result]()
        for row in matrix {
            for item in row {
                vector.append(item)
            }
        }
        return vector
    }

    func getDayOfWeek(today:String)->Int {
        
        let formatter  = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let todayDate = formatter.date(from: today)!
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let myComponents = myCalendar.components(.weekday, from: todayDate)
        let weekDay = myComponents.weekday
        return weekDay!
    }
    
    func getDayInString(date: Date = Date()) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        return result
    }
    
    func share(week: Int) {
        var results: String = ""
        for result in self.results! {
            results = "\(results)\n\(result.answers)"
        }
        self.saveAndExport(string: results)
    }
    

    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        //self.calendarHeightConstraint.constant = bounds.height+10;
        self.view.layoutIfNeeded()
        self.calendarView.frame = CGRect(origin: self.calendarView.frame.origin, size: bounds.size)
        self.view.updateConstraintsIfNeeded()
        self.view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        for result in self.results! {
            if(result.date == getDayInString(date: date)){
                performSegue(withIdentifier: Constants.Segues.ShowAnswers, sender: self.searchFrom(date: result.date))
            }
        }
    }
    
    func swipeTableCell(_ cell: MGSwipeTableCell, tappedButtonAt index: Int, direction: MGSwipeDirection, fromExpansion: Bool) -> Bool {
        
        if (direction == .rightToLeft && index == 0) {
            let indexPath = self.tableView.indexPath(for: cell)
            self.tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath!], with: .fade)
            self.matrixOfDates[(indexPath?.section)!].remove(at: (indexPath?.row)!)
            self.results = convertToVector(matrix: self.matrixOfDates)
            self.tableView.endUpdates()
            UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: self.results), forKey: "Results")
            UserDefaults.standard.synchronize()
            
        }
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let date = (self.matrixOfDates[indexPath.section][indexPath.row]).date
        self.performSegue(withIdentifier: Constants.Segues.ShowAnswers, sender: self.searchFrom(date: date))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == Constants.Segues.ShowAnswers){
            let answersViewController: AnswersViewController = segue.destination as! AnswersViewController
            answersViewController.counter = sender as? Int
        }
    }
    
    func searchFrom(date: String) -> Int{
        var counter: Int = 0
        for result: Result in self.results! {
            if(result.date == date){
                return counter
            }
            counter = counter+1
        }
        return 0
    }

}
