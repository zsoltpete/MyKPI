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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chartView.delegate = self;
        
        chartView.drawBarShadowEnabled = false;
        chartView.drawValueAboveBarEnabled = true;
        
        chartView.maxVisibleCount = 60;
        
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
        self.setData(count: 1, range: 1)
    }
    
    func setData(count: Int, range: Double){
        let start: Double = 1.0;
        
        var yVals = [BarChartDataEntry]()
        var loopCounter = start
        while loopCounter <= start+Double(count+1)
        {
            var mult: Double = (range + 1)
            var val: Double = (Double) (arc4random_uniform(UInt32(mult)))
            yVals.append(BarChartDataEntry(x: Double(loopCounter), y: val))
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
            set1?.label = "The year 2017"
            set1?.values = yVals
            set1?.setColor(ChartColorTemplates.colorFromString("111,111,111"))
            
            var dataSets = [BarChartDataSet]()
            dataSets.append(set1!)
            
            var data:BarChartData = BarChartData()
            data.dataSets = dataSets
            
            data.barWidth = 0.9;
            
            chartView.data = data;
        }
    }
    
}
