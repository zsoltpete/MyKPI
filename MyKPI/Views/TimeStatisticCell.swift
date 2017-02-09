//
//  TimeStatisticCell.swift
//  MyKPI
//
//  Created by Zsolt Pete on 04/02/17.
//  Copyright © 2017 petez. All rights reserved.
//

import UIKit
import Charts

class TimeStatisticCell: UITableViewCell, ChartViewDelegate {
    
    @IBOutlet weak var chartView: PieChartView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        chartView.delegate = self
        
        self.initChartView()
        chartView.backgroundColor = UIColor.flatSkyBlue
        
    }
    
    func initChartView(){
        
        chartView.animate(xAxisDuration: 1.4, easingOption: .easeOutBack)
        chartView.holeColor = UIColor.flatSkyBlue
    }
    
    func setData(index: Int, datas: [Result]){
        
        var values = [PieChartDataEntry]()
        var loopCounter = 0
        var allSum: Double = 0.0
        var workedSum: Double  = 0.0
        while loopCounter < datas.count
        {
            let actualAnswer: String = datas[loopCounter].answers
            let answerElementsString: [String] = actualAnswer.components(separatedBy: ",")
            allSum += convertStringDateToDouble(date: answerElementsString[9])
            workedSum += convertStringDateToDouble(date: answerElementsString[18])
            loopCounter=loopCounter+1
        }
        var chart: PieChartDataEntry = PieChartDataEntry(value: allSum-workedSum)
        values.append(chart)
        chart = PieChartDataEntry(value:workedSum)
        values.append(chart)
        
        
        
        let dataSet = PieChartDataSet(values: values, label: "Time")
        dataSet.sliceSpace = 2.0
        
        var colors = [UIColor.flatSkyBlueDark, UIColor.flatBlue]
        dataSet.colors = colors
        
        let data = PieChartData(dataSet: dataSet)
        chartView.data = data
        
        chartView.chartDescription?.enabled = false
        let l: Legend = chartView.legend;
        l.enabled = false
        
    }
    
    func convertStringDateToDouble(date: String) -> Double{
        let dateElements: [String] = date.components(separatedBy: ":")
        var doubledDate: Double = Double(dateElements[0])!
        doubledDate += Double(Double(dateElements[1])!/60.0)
        return doubledDate
    }
}



