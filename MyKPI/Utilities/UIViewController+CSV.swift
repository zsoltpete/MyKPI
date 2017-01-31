//
//  UIViewController+CSV.swift
//  MyKPI
//
//  Created by Zsolt Pete on 29/01/17.
//  Copyright © 2017 petez. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func saveAndExport(string: String){
        
        let exportFilePath = NSTemporaryDirectory() + "export.csv"
        let exportFileURL = URL(fileURLWithPath: exportFilePath)
        FileManager.default.createFile(atPath: exportFilePath, contents: Data(), attributes: nil)
        var fileHandlerError: NSError? = nil
        var fileHandle: FileHandle? = nil
        do{
            fileHandle = try FileHandle(forWritingTo: exportFileURL)
        }catch{
            print("Error with Handle")
        }
        if(fileHandle != nil){
            fileHandle?.seekToEndOfFile()
            let csvData = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
            fileHandle!.write(csvData!)
            
            fileHandle!.closeFile()
            
            let firstActivityItem = URL(fileURLWithPath: exportFilePath)
            let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [firstActivityItem], applicationActivities: nil)
            
            activityViewController.excludedActivityTypes = [.print, .message]
            
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    
}
