//
//  ViewController.swift
//  LemonadeStand
//
//  Created by Rob Passaro on 12/5/14.
//  Copyright (c) 2014 Rob Passaro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Konstant Constants, yuck yuck
    
    let kHalf : CGFloat = 1.0 / 2.0
    let kThird : CGFloat = 1.0 / 3.0
    let kFourth : CGFloat = 1.0 / 4.0
    let kFifth : CGFloat = 1.0 / 5.0
    let kSixth : CGFloat = 1.0 / 6.0
    let kEighth : CGFloat = 1.0 / 8.0
    
    let kMarginForView : CGFloat = 10.0           // side and top margins for views
    let kMarginForStatusBar : CGFloat = 10.0     // allow room for status bar at top
    
    let kDefaultStringWidth = "XXX"
 
    // STATE VARIABLES
    
    var dollars = 10
    var lemons = 1
    var cubes = 1
    var sales = 0
    
    var lemonsOrdered = 0
    var cubesOrdered = 0
    
    var lemonsMixed = 0
    var cubesMixed = 0
    var lemonadeRatio = 0.0
    
    var weather = ""
    var taste = ""
    var customers = ""
    var cashEarned = ""
    
    var customerArray:[Customer] = []
    
    // CONTAINERS
    
    var statusContainer : UIView!
    var purchaseContainer : UIView!
    var mixContainer : UIView!
    var sellContainer : UIView!
    
    // LABELS
    
    var titleLabel: UILabel!    // for name of app?
    
    // statusContainer labels
    var statusLabel : UILabel!
    var cashAmountLabel : UILabel!           // LABEL for cash user has
    var cashUnitsLabel : UILabel!
    var lemonsAmountLabel : UILabel!        // LABEL for number of lemons user has
    var lemonsUnitsLabel : UILabel!
    var iceAmountLabel : UILabel!           // LABEL for number of ice cubes
    var iceUnitsLabel : UILabel!
    
    // purchaseContainer labels
    var buyLemonsLabel : UILabel!            // This changed to function as label for whole container
    var numberLemonsLabel : UILabel!
    var lemonsRateLabel : UILabel!
    var numberCubesLabel: UILabel!
    var cubesRateLabel : UILabel!
    
    // mixContainer labels
    var mixLabel : UILabel!
    var mixQuantityLemonsLabel : UILabel!
    var mixLemonsLabel : UILabel!
    var mixQuantityCubesLabel : UILabel!
    var mixCubesLabel : UILabel!
    var mixTartRatioLabel: UILabel!
    
    // sellContainer labels
    var sellYesterdayLabel : UILabel!
    var sellWeatherLabel : UILabel!
    var sellTasteLabel : UILabel!
    var sellCustomersLabel : UILabel!
    var sellCashLabel : UILabel!
    
    // BUTTONS

    // for purchaseContainer
    var lemonPlusButton : UIButton!
    var lemonMinusButton : UIButton!
    var cubesPlusButton : UIButton!
    var cubesMinusButton : UIButton!
    
    // for mixContainer
    var mixLemonsPlusButton : UIButton!
    var mixLemonsMinusButton : UIButton!
    var mixCubesPlusButton : UIButton!
    var mixCubesMinusButton : UIButton!
    
    // for sellContainer
    var billMurrayButton : UIButton!        // Groundhog Day reference
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // this draws the intial 4 containers
        setupContainerViews()
        
        // these create and detail the things that live within each container
        setupStatusContainer(self.statusContainer)
        setupPurchaseContainer(self.purchaseContainer)
        setupMixContainerView(self.mixContainer)
        setupSellContainerView(self.sellContainer)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // BUTON ACTION FUNCTIONS
    
    // purchaseContainer button actions
    
    func lemonPlusButtonPressed (button : UIButton) {
        println("BUY a LEMON")
        if dollars <= 1 {
            showAlertWithText(header: "Not Enough $ for More Lemons", message: "Do something else")
        } else {
            dollars = dollars - 2
            lemons = lemons + 1
            lemonsOrdered = lemonsOrdered + 1
            updateMainView()
        }
    }

    func lemonMinusButtonPressed (button: UIButton) {
        println("RETURN a LEMON")
        if lemonsOrdered <= 0 || lemons <= 0 {
            showAlertWithText(header: "No Lemons to Return", message: "Do something else")
        } else {
            dollars = dollars + 2
            lemons = lemons - 1
            lemonsOrdered = lemonsOrdered - 1
            updateMainView()
        }
    }
    
    func cubesPlusButtonPressed (button : UIButton) {
        println("BUY an ICE CUBE")
        if dollars <= 0 {
            showAlertWithText(header: "Not Enough $ for More Ice", message: "Do something else")
        } else {
            dollars = dollars - 1
            cubes = cubes + 1
            cubesOrdered = cubesOrdered + 1
            updateMainView()
        }

    }
    
    func cubesMinusButtonPressed (button : UIButton) {
        println("RETURN an ICE CUBE")
        if cubesOrdered <= 0 || cubes <= 0 {
            showAlertWithText(header: "No Cubes to Return", message: "Do something else")
        } else {
            dollars = dollars + 1
            cubes = cubes - 1
            cubesOrdered = cubesOrdered - 1
            updateMainView()
        }

    }
    
    // mixContainer button actions
    
    func mixLemonsPlusButtonPressed (button : UIButton) {
        println("ADD a lemon to the mix")

        if lemons <= 0 {
            showAlertWithText(header: "No More Lemons to Mix", message: "buy some lemons")
        } else {
            lemons = lemons - 1
            lemonsMixed = lemonsMixed + 1
            
            if cubesMixed <= 0 {
                // change tart label to say that cubes are needed
                self.mixTartRatioLabel.text = "add ice cubes"
            } else {
                lemonadeRatio = Double(lemonsMixed) / Double(cubesMixed)
                self.mixTartRatioLabel.text = "LEMONADE RATIO = \(lemonadeRatio)"
            }

        updateMainView()

        }
    }
    
    func mixLemonsMinusButtonPressed (button : UIButton) {
        println("SUBTRACT a lemon from the mix")

        if lemonsMixed <= 0 {
            showAlertWithText(header: "No More Lemons to Remove", message: "add some lemons")
        } else {
            lemons = lemons + 1
            lemonsMixed = lemonsMixed - 1
            
            if cubesMixed <= 0 {
                // change tart label to say that cubes are needed
                self.mixTartRatioLabel.text = "add ice cubes"
            } else {
                lemonadeRatio = Double(lemonsMixed) / Double(cubesMixed)
                self.mixTartRatioLabel.text = "LEMONADE RATIO = \(lemonadeRatio)"
            }
        updateMainView()
        }
        
    }
    func mixCubesPlusButtonPressed (button : UIButton) {
        println("ADD a cube to the mix")

        if cubes <= 0 {
            showAlertWithText(header: "No More Ice Cubes to Mix", message: "buy some ice cubes")
        } else {
            cubes = cubes - 1
            cubesMixed = cubesMixed + 1
            
            if cubesMixed <= 0 {
                // change tart label to say that cubes are needed
                self.mixTartRatioLabel.text = "add ice cubes"
            } else {
                lemonadeRatio = Double(lemonsMixed) / Double(cubesMixed)
                self.mixTartRatioLabel.text = "LEMONADE RATIO = \(lemonadeRatio)"
            }
            updateMainView()
        }
    }
    
    func mixCubesMinusButtonPressed (button : UIButton) {
        println("SUBTRACT a cube from the mix")
        
        if cubesMixed <= 0 {
            showAlertWithText(header: "No More Ice Cubes to Remove", message: "add some ice cubes")
        } else {
            cubes = cubes + 1
            cubesMixed = cubesMixed - 1
            
            if cubesMixed <= 0 {
                // change tart label to say that cubes are needed
                self.mixTartRatioLabel.text = "add ice cubes"
            } else {
                lemonadeRatio = Double(lemonsMixed) / Double(cubesMixed)
                self.mixTartRatioLabel.text = "LEMONADE RATIO = \(lemonadeRatio)"
            }
            updateMainView()
        }
        
    }
    
    // sellContainer button actions
    
    func billMurrayButtonPressed (button : UIButton) {

        println("START THE DAY")
        
        // create an array of random customers for the day
        customerArray = Factory.createCustomers()

        // calculate sales
        sales = SalesBrain.ComputeSales(customerArray, todaysTartRatio: lemonadeRatio)

        // add todaysSales to the global variable 'dollars'
        dollars = dollars + sales
        
        // reset the mix components back to zero
        lemonsMixed = 0
        cubesMixed = 0
        
        // update the labels to correspond to the updated global variables
        updateMainView()
        
    }
    
    func setupContainerViews () {
        
        self.purchaseContainer = UIView(frame: CGRect(
            x: self.view.bounds.origin.x + kMarginForView,
            y: self.view.bounds.origin.y + kMarginForView + kMarginForStatusBar,
            width: self.view.bounds.width - 2 * kMarginForView,
            height: (self.view.bounds.height - kMarginForStatusBar) * kFourth - kMarginForView
            ))
        self.purchaseContainer.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(self.purchaseContainer)

        self.statusContainer = UIView(frame:CGRect(
            x: self.view.bounds.origin.x + kMarginForView,
            y: purchaseContainer.frame.height + 2 * kMarginForView + kMarginForStatusBar,
            width: self.view.bounds.width - 2 * kMarginForView,
            height: (self.view.bounds.height - kMarginForStatusBar) * kFourth - kMarginForView
            ))
        self.statusContainer.backgroundColor = UIColor.darkGrayColor()
        self.view.addSubview(self.statusContainer)
        
        self.mixContainer = UIView(frame: CGRect(
            x: self.view.bounds.origin.x + kMarginForView,
            y: statusContainer.frame.height + purchaseContainer.frame.height + 3 * kMarginForView + kMarginForStatusBar,
            width: self.view.bounds.width - 2 * kMarginForView,
            height: (self.view.bounds.height - kMarginForStatusBar) * kFourth - kMarginForView
            ))
        self.mixContainer.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(self.mixContainer)
        
        self.sellContainer = UIView(frame: CGRect(
            x: self.view.bounds.origin.x + kMarginForView,
            y: statusContainer.frame.height + purchaseContainer.frame.height + mixContainer.frame.height + 4 * kMarginForView + kMarginForStatusBar,
            width: self.view.bounds.width - 2 * kMarginForView,
            height: (self.view.bounds.height - kMarginForStatusBar) * kFourth - (2 * kMarginForView)
            ))
        self.sellContainer.backgroundColor = UIColor.darkGrayColor()
        self.view.addSubview(self.sellContainer)
        
    }
    
    // these "helper" functions create containers of specific geometry, in this case, "reactively"
    
    func setupStatusContainer(containerView: UIView) {

        self.statusLabel = UILabel()
        self.statusLabel.text = "2 - INVENTORY"
        self.statusLabel.textColor = UIColor.grayColor()
        self.statusLabel.font = UIFont(name: "Arial", size: 16)
        self.statusLabel.sizeToFit()
        self.statusLabel.center = CGPoint(x: containerView.frame.width * kEighth * 4, y: containerView.frame.height * kEighth)
        containerView.addSubview(self.statusLabel)
        
        self.cashAmountLabel = UILabel()
        self.cashAmountLabel.text = kDefaultStringWidth     // hack
        self.cashAmountLabel.textColor = UIColor.greenColor()
        self.cashAmountLabel.font = UIFont(name: "Arial", size: 40)
        self.cashAmountLabel.sizeToFit()
        self.cashAmountLabel.text = "$\(dollars)"
        self.cashAmountLabel.center = CGPoint(x: containerView.frame.width * kEighth, y: containerView.frame.height * kHalf)
        self.cashAmountLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.cashAmountLabel)
        
        self.cashUnitsLabel = UILabel()
        self.cashUnitsLabel.text = "CASH"
        self.cashUnitsLabel.textColor = UIColor.grayColor()
        self.cashUnitsLabel.font = UIFont(name: "Arial", size: 12)
        self.cashUnitsLabel.sizeToFit()
        self.cashUnitsLabel.center = CGPoint(x: containerView.frame.width * kEighth, y: containerView.frame.height * 4 * kSixth)
        self.cashUnitsLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.cashUnitsLabel)
        
        self.lemonsAmountLabel = UILabel()
        self.lemonsAmountLabel.text = kDefaultStringWidth     // hack
        self.lemonsAmountLabel.textColor = UIColor.yellowColor()
        self.lemonsAmountLabel.font = UIFont(name: "Arial", size: 75)
        self.lemonsAmountLabel.sizeToFit()
        self.lemonsAmountLabel.text = "\(lemons)"
        self.lemonsAmountLabel.center = CGPoint(x: containerView.frame.width * kEighth * 3, y: containerView.frame.height * kHalf)
        self.lemonsAmountLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.lemonsAmountLabel)
        
        self.lemonsUnitsLabel = UILabel()
        self.lemonsUnitsLabel.text = "LEMON"
        self.lemonsUnitsLabel.textColor = UIColor.grayColor()
        self.lemonsUnitsLabel.font = UIFont(name: "Arial", size: 12)
        self.lemonsUnitsLabel.sizeToFit()
        self.lemonsUnitsLabel.center = CGPoint(x: containerView.frame.width * kEighth * 3, y: containerView.frame.height * 5 * kSixth)
        self.lemonsUnitsLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.lemonsUnitsLabel)
        
        self.iceAmountLabel = UILabel()
        self.iceAmountLabel.text = kDefaultStringWidth     // hack
        self.iceAmountLabel.textColor = UIColor.whiteColor()
        self.iceAmountLabel.font = UIFont(name: "Arial", size: 75)
        self.iceAmountLabel.sizeToFit()
        self.iceAmountLabel.text = "\(cubes)"
        self.iceAmountLabel.center = CGPoint(x: containerView.frame.width * kEighth * 5, y: containerView.frame.height * kHalf)
        self.iceAmountLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.iceAmountLabel)
        
        self.iceUnitsLabel = UILabel()
        self.iceUnitsLabel.text = "CUBE"
        self.iceUnitsLabel.textColor = UIColor.grayColor()
        self.iceUnitsLabel.font = UIFont(name: "Arial", size: 12)
        self.iceUnitsLabel.sizeToFit()
        self.iceUnitsLabel.center = CGPoint(x: containerView.frame.width * kEighth * 5, y: containerView.frame.height * 5 * kSixth)
        self.iceUnitsLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.iceUnitsLabel)
        
    }
    
    func setupPurchaseContainer(containerView: UIView) {
        
        self.lemonPlusButton = UIButton()
        self.lemonPlusButton.setTitle("+", forState: UIControlState.Normal)
        self.lemonPlusButton.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        self.lemonPlusButton.titleLabel?.font = UIFont(name: "Arial", size: 80)
        self.lemonPlusButton.frame = CGRectMake(
            0,  // this parameter overwritten below by .center
            0,  // same
            50,
            50
        )
        // note: I realize the use of .center and .frame above is somewhat redundant, but was the only way I could figure out how to get the placement of the button as well as dictate its shape, as sizeToFit was not working well (it was taller than necessary, and overlapped with button below it)
        self.lemonPlusButton.center = CGPoint(
            x: containerView.frame.width * kEighth,
            y: containerView.frame.height * kThird)
//        self.lemonPlusButton.backgroundColor = UIColor.lightGrayColor()
        self.lemonPlusButton.addTarget(self, action: "lemonPlusButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.lemonPlusButton)
        
        self.lemonMinusButton = UIButton()
        self.lemonMinusButton.setTitle("-", forState: UIControlState.Normal)
        self.lemonMinusButton.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        self.lemonMinusButton.titleLabel?.font = UIFont(name: "Arial", size: 80)
        self.lemonMinusButton.frame = CGRectMake(
            0,  // overwritten below
            0,  // same
            50,
            50
        )
        self.lemonMinusButton.center = CGPoint(
            x: containerView.frame.width * kEighth,
            y: containerView.frame.height * kThird * 2)
//        self.lemonMinusButton.backgroundColor = UIColor.grayColor()
        self.lemonMinusButton.addTarget(self, action: "lemonMinusButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.lemonMinusButton)
        
        self.buyLemonsLabel = UILabel()
        self.buyLemonsLabel.text = "1 - ORDER"
        self.buyLemonsLabel.textColor = UIColor.darkGrayColor()
        self.buyLemonsLabel.font = UIFont(name: "Arial", size: 16)
        self.buyLemonsLabel.sizeToFit()
        self.buyLemonsLabel.center = CGPoint(x: containerView.frame.width * kEighth * 4, y: containerView.frame.height * kEighth)
        containerView.addSubview(self.buyLemonsLabel)

        self.numberLemonsLabel = UILabel()
        self.numberLemonsLabel.text = kDefaultStringWidth     // hack
        self.numberLemonsLabel.textColor = UIColor.yellowColor()
        self.numberLemonsLabel.font = UIFont(name: "Arial", size: 75)
        self.numberLemonsLabel.sizeToFit()
        self.numberLemonsLabel.text = "0"
        self.numberLemonsLabel.center = CGPoint(x: containerView.frame.width * kEighth * 3, y: containerView.frame.height * kHalf)
        self.numberLemonsLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.numberLemonsLabel)
        
        self.lemonsRateLabel = UILabel()
        self.lemonsRateLabel.text = "@$2/lemon"
        self.lemonsRateLabel.textColor = UIColor.darkGrayColor()
        self.lemonsRateLabel.font = UIFont(name: "Arial", size: 12)
        self.lemonsRateLabel.sizeToFit()
        self.lemonsRateLabel.center = CGPoint(x: containerView.frame.width * kEighth * 3, y: containerView.frame.height * kEighth * 7)
        self.lemonsRateLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.lemonsRateLabel)
        
        self.cubesPlusButton = UIButton()
        self.cubesPlusButton.setTitle("+", forState: UIControlState.Normal)
        self.cubesPlusButton.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        self.cubesPlusButton.titleLabel?.font = UIFont(name: "Arial", size: 80)
        self.cubesPlusButton.frame = CGRectMake(
            containerView.frame.width * kFourth * 3,    // this parameter is overwritten in .center below
            0,                                          // this one too.
            50,
            50
        )
        self.cubesPlusButton.center = CGPoint(
            x: containerView.frame.width * kEighth * 7,
            y: containerView.frame.height * kThird)
//        self.cubesPlusButton.backgroundColor = UIColor.lightGrayColor()
        self.cubesPlusButton.addTarget(self, action: "cubesPlusButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.cubesPlusButton)
        
        self.cubesMinusButton = UIButton()
        self.cubesMinusButton.setTitle("-", forState: UIControlState.Normal)
        self.cubesMinusButton.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        self.cubesMinusButton.titleLabel?.font = UIFont(name: "Arial", size: 80)
        self.cubesMinusButton.frame = CGRectMake(
            containerView.frame.width * kFourth * 3,
            containerView.frame.height * kHalf,
            50,
            50
        )
        self.cubesMinusButton.center = CGPoint(
            x: containerView.frame.width * kEighth * 7,
            y: containerView.frame.height * kThird * 2)
//        self.cubesMinusButton.backgroundColor = UIColor.blueColor()
        self.cubesMinusButton.addTarget(self, action: "cubesMinusButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.cubesMinusButton)
 
        self.numberCubesLabel = UILabel()
        self.numberCubesLabel.text = kDefaultStringWidth     // hack
        self.numberCubesLabel.textColor = UIColor.whiteColor()
        self.numberCubesLabel.font = UIFont(name: "Arial", size: 75)
        self.numberCubesLabel.sizeToFit()
        self.numberCubesLabel.text = "0"
        self.numberCubesLabel.center = CGPoint(x: containerView.frame.width * kEighth * 5, y: containerView.frame.height * kHalf)
        self.numberCubesLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.numberCubesLabel)
        
        self.cubesRateLabel = UILabel()
        self.cubesRateLabel.text = "@$1/cube"
        self.cubesRateLabel.textColor = UIColor.darkGrayColor()
        self.cubesRateLabel.font = UIFont(name: "Arial", size: 12)
        self.cubesRateLabel.sizeToFit()
        self.cubesRateLabel.center = CGPoint(x: containerView.frame.width * kEighth * 5, y: containerView.frame.height * kEighth * 7)
        self.cubesRateLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.cubesRateLabel)
        
    }
    
    func setupMixContainerView(containerView: UIView) {

        self.mixLabel = UILabel()
        self.mixLabel.text = "3 - MIX"
        self.mixLabel.textColor = UIColor.darkGrayColor()
        self.mixLabel.font = UIFont(name: "Arial", size: 16)
        self.mixLabel.sizeToFit()
        self.mixLabel.center = CGPoint(x: containerView.frame.width * kEighth * 4, y: containerView.frame.height * kEighth)
        containerView.addSubview(self.mixLabel)
        
        self.mixLemonsPlusButton = UIButton()
        self.mixLemonsPlusButton.setTitle("+", forState: UIControlState.Normal)
        self.mixLemonsPlusButton.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        self.mixLemonsPlusButton.titleLabel?.font = UIFont(name: "Arial", size: 80)
        self.mixLemonsPlusButton.frame = CGRectMake(
            0,
            0,
            50,
            50
        )
        self.mixLemonsPlusButton.center = CGPoint(
            x: containerView.frame.width * kEighth,
            y: containerView.frame.height * kThird)
        self.mixLemonsPlusButton.addTarget(self, action: "mixLemonsPlusButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.mixLemonsPlusButton)
        
        self.mixLemonsMinusButton = UIButton()
        self.mixLemonsMinusButton.setTitle("-", forState: UIControlState.Normal)
        self.mixLemonsMinusButton.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        self.mixLemonsMinusButton.titleLabel?.font = UIFont(name: "Arial", size: 80)
        self.mixLemonsMinusButton.frame = CGRectMake(
            0,
            0,
            50,
            50
        )
        self.mixLemonsMinusButton.center = CGPoint(
            x: containerView.frame.width * kEighth,
            y: containerView.frame.height * kThird * 2)
        self.mixLemonsMinusButton.addTarget(self, action: "mixLemonsMinusButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.mixLemonsMinusButton)

        self.mixQuantityLemonsLabel = UILabel()
        self.mixQuantityLemonsLabel.text = kDefaultStringWidth     // hack
        self.mixQuantityLemonsLabel.textColor = UIColor.yellowColor()
        self.mixQuantityLemonsLabel.font = UIFont(name: "Arial", size: 75)
        self.mixQuantityLemonsLabel.sizeToFit()
        self.mixQuantityLemonsLabel.text = "0"
        self.mixQuantityLemonsLabel.center = CGPoint(x: containerView.frame.width * kEighth * 3, y: containerView.frame.height * kEighth * kHalf * 7)
        self.mixQuantityLemonsLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.mixQuantityLemonsLabel)

        self.mixLemonsLabel = UILabel()
        self.mixLemonsLabel.text = "LEMONS"
        self.mixLemonsLabel.textColor = UIColor.darkGrayColor()
        self.mixLemonsLabel.font = UIFont(name: "Arial", size: 12)
        self.mixLemonsLabel.sizeToFit()
        self.mixLemonsLabel.center = CGPoint(x: containerView.frame.width * kEighth * 3, y: containerView.frame.height * kEighth * 6)
        self.mixLemonsLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.mixLemonsLabel)
        
        self.mixCubesPlusButton = UIButton()
        self.mixCubesPlusButton.setTitle("+", forState: UIControlState.Normal)
        self.mixCubesPlusButton .setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        self.mixCubesPlusButton.titleLabel?.font = UIFont(name: "Arial", size: 80)
        self.mixCubesPlusButton.frame = CGRectMake(
            0,
            0,
            50,
            50
        )
        self.mixCubesPlusButton.center = CGPoint(
            x: containerView.frame.width * kEighth * 7,
            y: containerView.frame.height * kThird)
        self.mixCubesPlusButton.addTarget(self, action: "mixCubesPlusButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.mixCubesPlusButton)
        
        self.mixCubesMinusButton = UIButton()
        self.mixCubesMinusButton.setTitle("-", forState: UIControlState.Normal)
        self.mixCubesMinusButton.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        self.mixCubesMinusButton.titleLabel?.font = UIFont(name: "Arial", size: 80)
        self.mixCubesMinusButton.frame = CGRectMake(
            0,
            0,
            50,
            50
        )
        self.mixCubesMinusButton.center = CGPoint(
            x: containerView.frame.width * kEighth * 7,
            y: containerView.frame.height * kThird * 2)
        self.mixCubesMinusButton.addTarget(self, action: "mixCubesMinusButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.mixCubesMinusButton)

        self.mixQuantityCubesLabel = UILabel()
        self.mixQuantityCubesLabel.text = kDefaultStringWidth     // hack
        self.mixQuantityCubesLabel.textColor = UIColor.whiteColor()
        self.mixQuantityCubesLabel.font = UIFont(name: "Arial", size: 75)
        self.mixQuantityCubesLabel.sizeToFit()
        self.mixQuantityCubesLabel.text = "0"
        self.mixQuantityCubesLabel.center = CGPoint(x: containerView.frame.width * kEighth * 5, y: containerView.frame.height * kEighth * kHalf * 7)
        self.mixQuantityCubesLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.mixQuantityCubesLabel)

        self.mixCubesLabel = UILabel()
        self.mixCubesLabel.text = "CUBES"
        self.mixCubesLabel.textColor = UIColor.darkGrayColor()
        self.mixCubesLabel.font = UIFont(name: "Arial", size: 12)
        self.mixCubesLabel.sizeToFit()
        self.mixCubesLabel.center = CGPoint(x: containerView.frame.width * kEighth * 5, y: containerView.frame.height * kEighth * 6)
        self.mixCubesLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.mixCubesLabel)
        
        self.mixTartRatioLabel = UILabel()
        self.mixTartRatioLabel.text = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX"     // hack
        self.mixTartRatioLabel.textColor = UIColor.darkGrayColor()
        self.mixTartRatioLabel.font = UIFont(name: "Arial", size: 16)
        self.mixTartRatioLabel.sizeToFit()
        self.mixTartRatioLabel.text = "flavor"
        self.mixTartRatioLabel.center = CGPoint(x: containerView.frame.width * kEighth * 4, y: containerView.frame.height * kEighth * kFourth * 29)
        self.mixTartRatioLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.mixTartRatioLabel)
        
    }
    
    func setupSellContainerView(containerView: UIView) {

        self.sellYesterdayLabel = UILabel()
        self.sellYesterdayLabel.text = "THE PAST"
        self.sellYesterdayLabel.textColor = UIColor.lightGrayColor()
        self.sellYesterdayLabel.font = UIFont(name: "Arial", size: 16)
        self.sellYesterdayLabel.sizeToFit()
        self.sellYesterdayLabel.center = CGPoint(x: containerView.frame.width * kHalf, y: containerView.frame.height * kEighth * kHalf * kHalf * 5)
        containerView.addSubview(self.sellYesterdayLabel)

        self.sellWeatherLabel = UILabel()
        self.sellWeatherLabel.text = "XXXXXXXXXXXXXXXXXXXXXXXXX"
        self.sellWeatherLabel.textColor = UIColor.lightGrayColor()
        self.sellWeatherLabel.font = UIFont(name: "Arial", size: 12)
        self.sellWeatherLabel.sizeToFit()
        self.sellWeatherLabel.text = "weather"
        self.sellWeatherLabel.center = CGPoint(x: containerView.frame.width * kThird, y: containerView.frame.height * kEighth * kHalf * 5)
        self.sellWeatherLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.sellWeatherLabel)
        
        self.sellTasteLabel = UILabel()
        self.sellTasteLabel.text = "XXXXXXXXXXXXXXXXXXXXXXXXX"
        self.sellTasteLabel.textColor = UIColor.lightGrayColor()
        self.sellTasteLabel.font = UIFont(name: "Arial", size: 12)
        self.sellTasteLabel.sizeToFit()
        self.sellTasteLabel.text = "flavor"
        self.sellTasteLabel.center = CGPoint(x: containerView.frame.width * kThird, y: containerView.frame.height * kEighth * kHalf * 7)
        self.sellTasteLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.sellTasteLabel)
        
        self.sellCustomersLabel = UILabel()
        self.sellCustomersLabel.text = "XXXXXXXXXXXXXXXXXXXXXXXXX"
        self.sellCustomersLabel.textColor = UIColor.lightGrayColor()
        self.sellCustomersLabel.font = UIFont(name: "Arial", size: 12)
        self.sellCustomersLabel.sizeToFit()
        self.sellCustomersLabel.text = "customers"
        self.sellCustomersLabel.center = CGPoint(x: containerView.frame.width * kThird * 2, y: containerView.frame.height * kEighth * kHalf * 5)
        self.sellCustomersLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.sellCustomersLabel)

        self.sellCashLabel = UILabel()
        self.sellCashLabel.text = "XXXXXXXXXXXXXXXXXXXXXXXXX"
        self.sellCashLabel.textColor = UIColor.lightGrayColor()
        self.sellCashLabel.font = UIFont(name: "Arial", size: 12)
        self.sellCashLabel.sizeToFit()
        self.sellCashLabel.text = "bucks"
        self.sellCashLabel.center = CGPoint(x: containerView.frame.width * kThird * 2 , y: containerView.frame.height * kEighth * kHalf * 7)
        self.sellCashLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.sellCashLabel)

        self.billMurrayButton = UIButton()
        self.billMurrayButton.setTitle("TO THE FUTURE!", forState: UIControlState.Normal)
        self.billMurrayButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.billMurrayButton.titleLabel?.font = UIFont(name: "Arial", size: 35)
        self.billMurrayButton.sizeToFit()
        self.billMurrayButton.center = CGPoint(x: containerView.frame.width * kHalf, y: containerView.frame.height * kFourth * 3)
        self.billMurrayButton.addTarget(self, action: "billMurrayButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.billMurrayButton)
        
    }
    
    func updateMainView () {

        // statusContainer labels
        
        self.cashAmountLabel.text = "$\(dollars)"
        self.lemonsAmountLabel.text = "\(lemons)"
        self.iceAmountLabel.text = "\(cubes)"
        
        // purchaseContainer labels
        
        self.numberLemonsLabel.text = "\(lemonsOrdered)"
        self.numberCubesLabel.text = "\(cubesOrdered)"
        
        // mixContainer labels
        
        self.mixQuantityLemonsLabel.text = "\(lemonsMixed)"
        self.mixQuantityCubesLabel.text = "\(cubesMixed)"
        
    }
    
    func showAlertWithText(header : String = "Warning", message : String) {
        
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
}

