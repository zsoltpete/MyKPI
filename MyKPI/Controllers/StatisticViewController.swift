//
//  StatisticViewController.swift
//  MyKPI
//
//  Created by Zsolt Pete on 31/01/17.
//  Copyright © 2017 petez. All rights reserved.
//

import UIKit


class StatisticViewController: UITableViewController {
    
    var results: [Result]? = [Result]()
    var answers: [Int]?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let decoded = UserDefaults.standard.object(forKey: "Results") as? Data {
            self.results = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as? [Result]
        }
        self.view.backgroundColor = UIColor.flatSkyBlue
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row < 3){
            let cell: FeelingsStatisticCell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.FeelingsStatisticCell, for: indexPath) as! FeelingsStatisticCell
            
            cell.setData(index: indexPath.row, range: 10, datas: self.results!)
            
            return cell
        }else if (indexPath.row == 3){
            let cell: ScrumCell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.ScrumCell, for: indexPath) as! ScrumCell
            
            cell.setData(index: 15, datas: self.results!)
            
            return cell
        }else if(indexPath.row == 4 || indexPath.row == 5){
            let cell: TimeStatisticCell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.TimeStatisticCell, for: indexPath) as! TimeStatisticCell
            
            cell.setData(index: 9, datas: self.results!)
            
            return cell
        }
        
        return UITableViewCell()
        
        
    }
    
   
    

    
}
