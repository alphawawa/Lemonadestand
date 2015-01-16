//
//  SalesBrain.swift
//  LemonadeStand
//
//  Created by Rob Passaro on 1/15/15.
//  Copyright (c) 2015 Rob Passaro. All rights reserved.
//

import Foundation
import UIKit

class SalesBrain {
    
    class func ComputeSales(todaysCustomers: [Customer] , todaysTartRatio : Double) -> Int {
        
        var numberOfCustomers = todaysCustomers.count
        var todaysSales = 0
        
        let kSweetLimit : Double       = 1.0 / 3.0
        let kNeutralLimit : Double    = 2.0 / 3.0
        let kTartLimit : Double        = 3.0 / 3.0        // yes, I know it equals 1
        
        for var i = 0; i < numberOfCustomers ; i++ {
            
            // traverse the array of customers, and if there is a taste match, increase sales
            if (todaysCustomers[i].lemonadePreference <= kSweetLimit) && (todaysTartRatio > 1.0) {
                todaysSales = todaysSales + 1
                println("Customer \(i) bought lemonade!")
            } else if (todaysCustomers[i].lemonadePreference <= kNeutralLimit) && (todaysCustomers[i].lemonadePreference > kNeutralLimit) && (todaysTartRatio == 1.0) {
                todaysSales = todaysSales + 1
                println("Customer \(i) bought lemonade!")
            } else if (todaysCustomers[i].lemonadePreference <= kTartLimit) && (todaysCustomers[i].lemonadePreference > kNeutralLimit) && (todaysTartRatio < 1.0) {
                todaysSales = todaysSales + 1
                println("Customer \(i) bought lemonade!")
            } else {
                println("Customer \(i) did NOT buy the lemonade.")
            }
        
        }        
        return todaysSales
    }
    
}