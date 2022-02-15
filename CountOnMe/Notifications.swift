//
//  Notifications.swift
//  CountOnMe
//
//  Created by Awaleh Moussa Hassan on 14/02/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import Foundation

//Extended the Notification.Name type with a custome one.
extension Notification.Name{
  static let dataDidChange = Notification.Name("DatadidChange")
}

extension Array where Element == String{
  
  var endsWithOperand: Bool{
    let operands = Operand.operands
    return operands.contains(self.last ?? "")
  }
}
