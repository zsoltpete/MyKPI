//
//  FeelingsStatisticCell.swift
//  MyKPI
//
//  Created by Zsolt Pete on 01/02/17.
//  Copyright © 2017 petez. All rights reserved.
//

import UIKit
import Charts

class FeelingsStatisticCell: UITableViewCell, ChartViewDelegate {

    @IBOutlet weak var chartView: BarChartView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initChartView()
    }
    
    func initChartView(){
        chartView.delegate = self;
        
        chartView.drawBarShadowEnabled = false;
        chartView.drawValueAboveBarEnabled = true;
        chartView.setScaleEnabled(false)
        chartView.doubleTapToZoomEnabled = false
        chartView.highlightPerTapEnabled = false
        chartView.chartDescription?.enabled = false
        chartView.borderColor = UIColor.white
        
        chartView.maxVisibleCount = 60;
        chartView.tintColor = UIColor.red
        
        
        let xAxis: XAxis = chartView.xAxis;
        xAxis.labelPosition = .bottom;
        xAxis.drawGridLinesEnabled = false;
        xAxis.granularity = 1.0; // only intervals of 1 day
        xAxis.labelCount = 10;
        xAxis.labelTextColor = UIColor.white
        xAxis.axisLineColor = UIColor.white
        let leftAxis: YAxis = chartView.leftAxis;
        
        leftAxis.labelPosition =  .outsideChart
        leftAxis.spaceTop = 0.15;
        leftAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
        leftAxis.labelTextColor = UIColor.white
        leftAxis.axisLineColor = UIColor.white
        leftAxis.gridColor = UIColor.white
        
        let rightAxis: YAxis = chartView.rightAxis;
        rightAxis.enabled = false;
        rightAxis.drawGridLinesEnabled = false;
        rightAxis.labelCount = 8;
        rightAxis.valueFormatter = leftAxis.valueFormatter;
        rightAxis.spaceTop = 0.15;
        rightAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
        rightAxis.labelTextColor = UIColor.white
        
        let l: Legend = chartView.legend;
        l.enabled = false

        

        chartView.backgroundColor = UIColor.flatSkyBlue
    }
    
    func setData(index: Int, range: Double, datas: [Result]){
        let start: Int = 0;
        
        var yVals = [BarChartDataEntry]()
        var loopCounter = start
        while loopCounter < datas.count
        {
            let actualAnswer: String = datas[loopCounter].answers
            let answerElementsString: [String] = actualAnswer.components(separatedBy: ",")
            let val: Double = (Double)(answerElementsString[Int(index)])!
            let barChart: BarChartDataEntry = BarChartDataEntry(x: Double(loopCounter), y: val)
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
            set1?.label = "The year 2017"
            set1?.values = yVals
            set1?.colors = [UIColor.flatSkyBlueDark]
            set1?.valueColors = [UIColor.white]
            var dataSets = [BarChartDataSet]()
            dataSets.append(set1!)
            var data:BarChartData = BarChartData()
            data.dataSets = dataSets
            
            
            data.barWidth = 0.9;
            chartView.data = data;
        }
    }

}
