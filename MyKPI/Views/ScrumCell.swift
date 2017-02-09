//
//  ScrumCell.swift
//  MyKPI
//
//  Created by Zsolt Pete on 04/02/17.
//  Copyright © 2017 petez. All rights reserved.
//

import UIKit
import Charts

class ScrumCell: UITableViewCell, ChartViewDelegate {

    @IBOutlet weak var chartView: LineChartView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initChartView()
    }

    func initChartView(){
        chartView.delegate = self;
        chartView.chartDescription?.enabled = false
        chartView.dragEnabled = false
        chartView.setScaleEnabled(false)
        chartView.pinchZoomEnabled = false
        chartView.drawGridBackgroundEnabled = false
/*
        let llXAxis: ChartLimitLine = ChartLimitLine(limit: 10.0, label: "Index 10")
        llXAxis.lineWidth = 4.0
        llXAxis.lineDashLengths = [10.0, 10.0, 0.0]
        llXAxis.labelPosition = .rightBottom
        llXAxis.valueFont = UIFont.boldSystemFont(ofSize: 10.0)
        */
        //Vertical
        chartView.xAxis.gridLineDashLengths = [0.0, self.frame.height]

        let ll1: ChartLimitLine = ChartLimitLine(limit: 5.0, label: "Daily Limit")
        ll1.lineWidth = 1.0
        ll1.lineDashLengths = [self.frame.width, 0.0]
        ll1.labelPosition = .rightTop
        ll1.valueFont = UIFont.boldSystemFont(ofSize: 5.0)
        ll1.valueTextColor = UIColor.flatBlueDark
        
        let xAxis: XAxis = chartView.xAxis
        xAxis.enabled = false
        
/*
        let ll2: ChartLimitLine = ChartLimitLine(limit: 150.0, label: "Upper Limi")
        ll2.lineWidth = 4.0
        ll2.lineDashLengths = [5.0, 5.0]
        ll2.labelPosition = .rightBottom
        ll2.valueFont = UIFont.boldSystemFont(ofSize: 10.0)*/
        
        
        //Horizontal
        let leftAxis = chartView.leftAxis
        leftAxis.removeAllLimitLines()
        leftAxis.addLimitLine(ll1)
        //leftAxis.addLimitLine(ll2)
        leftAxis.axisMaximum = 10
        leftAxis.axisMinimum = 0
        leftAxis.gridLineDashLengths = [0.0, self.frame.width]
        leftAxis.drawZeroLineEnabled = false
        leftAxis.drawLimitLinesBehindDataEnabled = false
        leftAxis.axisLineColor = UIColor.white
        leftAxis.labelTextColor = UIColor.white
        
        chartView.rightAxis.enabled = false

        let l: Legend = chartView.legend;
        l.enabled = false
        
        
        let marker: MarkerView = MarkerView()
        marker.chartView = chartView;
        chartView.marker = marker;
        chartView.backgroundColor = UIColor.flatSkyBlue
    }

    func setData(index: Int, datas: [Result]){
        
        var values = [ChartDataEntry]()
        var loopCounter = 0
        while loopCounter < datas.count
        {
            let actualAnswer: String = datas[loopCounter].answers
            let answerElementsString: [String] = actualAnswer.components(separatedBy: ",")
            let val: Double = (Double)(answerElementsString[Int(index)])!
            let chart: ChartDataEntry = ChartDataEntry(x: Double(loopCounter), y: val)
            values.append(chart)
            loopCounter=loopCounter+1
        }
        
        var set1:LineChartDataSet? = nil
        if (chartView.data != nil){
            set1 = chartView.data?.dataSets[0] as! LineChartDataSet
            set1?.values = values
            chartView.notifyDataSetChanged()
            chartView.data?.notifyDataChanged()
        }
        else{
            set1 = LineChartDataSet(values: values, label: "Dataset 1")
            
            set1?.lineDashLengths = [0.0,self.frame.width]
            set1?.setColor(UIColor.gray)
            set1?.setCircleColor(UIColor.blue)
            set1?.lineWidth = 1.0
            set1?.circleRadius = 3.0
            set1?.drawCirclesEnabled = false
            set1?.valueFont = UIFont.boldSystemFont(ofSize: 10.0)
            set1?.formLineDashLengths = [5.0, 2.5]
            set1?.formLineWidth = 0.0
            set1?.formSize = 15.0
            set1?.mode = .horizontalBezier
            set1?.valueColors = [UIColor.white]
            
            set1?.fillAlpha = 1.0
            set1?.drawFilledEnabled = true
            
            var dataSets = [LineChartDataSet]()
            dataSets.append(set1!)
            
            let data = LineChartData(dataSets: dataSets)
            chartView.data = data
            
        }
    }
}
