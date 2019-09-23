//
//  Extensions.swift
//  iOSTechnicalTest
//
//  Created by Anson on 23/9/19.
//  Copyright © 2019 Lomotif. All rights reserved.
//

import Foundation

extension NSObject {
    
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
