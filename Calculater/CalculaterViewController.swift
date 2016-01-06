//
//  CalculaterViewController.swift
//  Calculater
//
//  Created by appledev098 on 12/31/15.
//  Copyright © 2015 TonySong. All rights reserved.
//

import UIKit

class CalculaterViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    
    var userIsInTheMiddleOfTapingANumber = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTapingANumber {
        displayLabel.text = displayLabel.text! + digit
        } else {
            displayLabel.text = digit
            userIsInTheMiddleOfTapingANumber = true
        }
    }

    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTapingANumber {
            enter()
        }
        switch operation {
            case "×": performOperation { $0 * $1 }
            case "÷": performOperation { $0 / $1 }
            case "+": performOperation { $0 + $1 }
            case "−": performOperation { $0 - $1 }
            default: break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    var operandStack = Array<Double>()
    // String -> Double
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(displayLabel.text!)!.doubleValue
        }
        set {
            displayLabel.text = "\(newValue)"
            userIsInTheMiddleOfTapingANumber = false
        }
    }
    
    @IBAction func enter() {
        userIsInTheMiddleOfTapingANumber = false
        operandStack.append(displayValue)
    }
}
