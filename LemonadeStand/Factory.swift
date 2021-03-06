//
//  Factory.swift
//  LemonadeStand
//
//  Created by Rob Passaro on 1/15/15.
//  Copyright (c) 2015 Rob Passaro. All rights reserved.
//

import Foundation
import UIKit

class Factory {
    
    class func createCustomers(weather : Int) -> [Customer] {
        
        // create an array of type Customer into which we will populate with customers
        var tempCustomerArray:[Customer] = []
        
        // create a temporary variable of type Customer to help populate the array of customers
        var tempCustomer:Customer!
        
        // variable to which we will generate a random value to represent taste preference
        var customerLemonadePreference = 0.0
        
        // generate a random number in the range of 0 to 10 inclusive
        var numberCustomers = Int(arc4random_uniform(UInt32(11)))
        
        // add or subtract customers depending on the weather
        if (weather <= 3) {
            numberCustomers = numberCustomers + 4
            println("Sunny!  4 extra customers")
        } else if
            (weather <= 10) && (weather > 7) {
            numberCustomers = numberCustomers - 3
            println("COLD!  3 less customers")
        } else {
            println("Normal weather so no customer change")
        }

        // make sure numberCustomers is not negative
        if (numberCustomers < 0) {
            numberCustomers = 0
        }
        
        // generate a random number of customers, and give each customer a random taste preference
        for var i = 0 ; i <= numberCustomers ; i++ {
            
            // generate a random taste preference between 0 and 1.00
            customerLemonadePreference = Double(arc4random_uniform(UInt32(101))) / 100.0
            println("Customer \(i) has taste preference \(customerLemonadePreference)")
            
            // assign that preference to the temp Customer variable
            tempCustomer = Customer(lemonadePreference: customerLemonadePreference)

            // append that customer to the array of Customers
            tempCustomerArray.append(tempCustomer)
        }
        
        // return an array of type Customer
        return tempCustomerArray
        
    }
    
    class func createWeather() -> Int {
        
        var weatherNumber:Int!
        
        weatherNumber = Int(arc4random_uniform(UInt32(11)))
        
        return weatherNumber
    }
    
}
