//
//  String+Image.swift
//  MyKPI
//
//  Created by Zsolt Pete on 28/01/17.
//  Copyright © 2017 petez. All rights reserved.
//

import UIKit

extension String {
    func image() -> UIImage {
        let size = CGSize(width: 45, height: 45)
        UIGraphicsBeginImageContextWithOptions(size, false, 0);
        UIColor.clear.set()
        let rect = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: size)
        UIRectFill(CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: size))
        (self as NSString).draw(in: rect, withAttributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 40)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}
