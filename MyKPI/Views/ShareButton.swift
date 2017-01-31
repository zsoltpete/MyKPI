//
//  ShareButton.swift
//  MyKPI
//
//  Created by Zsolt Pete on 29/01/17.
//  Copyright © 2017 petez. All rights reserved.
//

import UIKit

class ShareButton: UIButton {

    var section: Int?
    var delegate: ShareProtocol?

}

protocol ShareProtocol {
    func share(week: Int)
}
