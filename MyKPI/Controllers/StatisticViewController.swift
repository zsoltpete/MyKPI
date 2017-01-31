//
//  StatisticViewController.swift
//  MyKPI
//
//  Created by Zsolt Pete on 31/01/17.
//  Copyright © 2017 petez. All rights reserved.
//

import UIKit
import Charts

class StatisticViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var chartView: BarChartView!
    var results: [Result]? = [Result]()
    var answers: [Int]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let decoded = UserDefaults.standard.object(forKey: "Results") as? Data {
            self.results = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as? [Result]
        }
        
        
        self.initChartView()
    }
    
    func initChartView(){
        chartView.delegate = self;
        
        chartView.drawBarShadowEnabled = false;
        chartView.drawValueAboveBarEnabled = true;
        
        chartView.maxVisibleCount = 60;
        chartView.tintColor = UIColor.red
        
        
        let xAxis: XAxis = chartView.xAxis;
        xAxis.labelPosition = .bottom;
        xAxis.drawGridLinesEnabled = false;
        xAxis.granularity = 1.0; // only intervals of 1 day
        xAxis.labelCount = 7;
        
        let leftAxis: YAxis = chartView.leftAxis;
        leftAxis.labelCount = 8;
        leftAxis.labelPosition =  .outsideChart
        leftAxis.spaceTop = 0.15;
        leftAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
        
        let rightAxis: YAxis = chartView.rightAxis;
        rightAxis.enabled = true;
        rightAxis.drawGridLinesEnabled = false;
        rightAxis.labelCount = 8;
        rightAxis.valueFormatter = leftAxis.valueFormatter;
        rightAxis.spaceTop = 0.15;
        rightAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
        
        let l: Legend = chartView.legend;
        l.horizontalAlignment = .left;
        l.verticalAlignment = .bottom;
        l.orientation = .horizontal;
        l.drawInside = false;
        l.form = .square;
        l.formSize = 9.0;
        l.xEntrySpace = 4.0;
        
        let marker: MarkerView = MarkerView()
        marker.chartView = chartView;
        chartView.marker = marker;
        self.setData(count: (self.results?.count)!, range: 10)
    }
    
    func setData(count: Int, range: Double){
        let start: Int = 0;
        
        var yVals = [BarChartDataEntry]()
        var loopCounter = start
        while loopCounter < (self.results?.count)!
        {
            var mult: Double = (range + 1)
            let actualAnswer: String = (self.results?[loopCounter].answers)!
            let answerElementsString: [String] = actualAnswer.components(separatedBy: ",")
            var val: Double = (Double)(answerElementsString[Int(0)])!
            var barChart: BarChartDataEntry = BarChartDataEntry(x: Double(loopCounter), y: val)
            yVals.append(barChart)
            
            loopCounter=loopCounter+1
        }
        
        var set1:BarChartDataSet? = nil
        if (chartView.data != nil){
            set1 = chartView.data?.dataSets[0] as? BarChartDataSet
            set1?.values = yVals;
            chartView.data?.notifyDataChanged()
            chartView.notifyDataSetChanged()
        }
        else{
            set1 = BarChartDataSet()
            set1?.setColor(NSUIColor.red)
            set1?.label = "The year 2017"
            set1?.values = yVals
            set1?.setColor(ChartColorTemplates.colorFromString("111,111,111"))
            set1?.colors = [UIColor.red, UIColor.green]
            var dataSets = [BarChartDataSet]()
            dataSets.append(set1!)
            
            var data:BarChartData = BarChartData()
            data.dataSets = dataSets
            
            data.barWidth = 0.9;
            chartView.data = data;
        }
    }
    
}
