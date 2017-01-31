//
//  Constants.swift
//  MyKPI
//
//  Created by Zsolt Pete on 28/01/17.
//  Copyright © 2017 petez. All rights reserved.
//

import UIKit

class Constants: NSObject {
    
    struct Cells {
        static var HistoryItemCell = "HistoryItemCell"
        static var KPIQuestionCell = "KPIQuestionCell"
        static var EditQuestionCell = "EditQuestionCell"
        static var NewQuestionTitleCell = "NewQuestionTitleCell"
        static var NewQuestionTypeCell = "NewQuestionTypeCell"
        static var HistorySectionHeaderCell = "HistorySectionHeaderCell"
        static var BadSideCell = "BadSideCell"
        static var AnswersCell = "AnswersCell"
    }
    
    struct Segues {
        static var ShowResult = "ShowResult"
        static var ShowStartKPI = "ShowStartKPI"
        static var ShowAddQuestion = "ShowAddQuestion"
        static var ShowTimerPicker = "ShowTimerPicker"
        static var ShowAnswers = "ShowAnswers"
    }
    
    struct Events {
        static var AddTimeAnswerEvent = "AddTimeAnswerEvent"
    }
    
    struct Fonts {
        static var PointFont = "Arial"
    }
    
    struct QuestionTypes {
            static var Feeling = "Feeling"
            static var Time = "Time"
            static var Point = "Point"
            static var TrueFalse = "TrueFalse"
    }
    
    struct AppDelegate {
        static var kAppDelegate = UIApplication.shared.delegate as! AppDelegate
    }

}
