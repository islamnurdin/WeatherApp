//
//  Extensions.swift
//  iOSSecondTask
//
//  Created by MacBook Pro on 7/6/18.
//  Copyright © 2018 Islam & Co. All rights reserved.
//

import Foundation


//Drawing bottom lines

extension UIView {
    func addBottomBorderWithColor(color: UIColor, width: CGFloat, height: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width - (-3), width: frame.size.width, height: height)
        self.layer.addSublayer(border)
    }
}
//
extension Date {
    func isSame(_ anotherDate: Date) -> Bool {
        let calendar = Calendar.autoupdatingCurrent
        let componentsSelf = calendar.dateComponents([.year, .month, .day], from: self)
        let componentsAnotherDate = calendar.dateComponents([.year, .month, .day], from: anotherDate)

        return componentsSelf.year == componentsAnotherDate.year && componentsSelf.month == componentsAnotherDate.month && componentsSelf.day == componentsAnotherDate.day
    }
}

