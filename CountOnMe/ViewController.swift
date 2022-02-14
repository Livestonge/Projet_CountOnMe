//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
	  var operationManager: OperationManager!
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//			An instance of the OperationManager
			  operationManager = OperationManager()
//			starts listenning to the dataDidChange notification.
			  NotificationCenter.default.addObserver(self,
																						 selector: #selector(updateView),
																						 name: .dataDidChange,
																						 object: nil)
			  
    }
    
//	Method called when the controller gets an notification
	@objc private func updateView(){
//	Updates the textview
		textView.text = operationManager.expression.joined(separator: "")
		
	}
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
//       Ask the model to add element.
			  operationManager?.add(element: numberText)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
			do{
//				Ask the operationManager to add an addition sign
				try operationManager.shoulAddOperand("+")
			}catch {
//				An error is thrown if it is not appropriate to do so
				handleThrown(error)
			}
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
			do{
//				Ask the operationManager to add an substraction sign
				try operationManager.shoulAddOperand("-")
			}catch {
//				An error is thrown if it is not appropriate to do so
				handleThrown(error)
			}
    }
	
	@IBAction func tappedMultiplicationButton(_ sender: UIButton){
		do{
//			Ask the operationManager to add an substraction sign
			try operationManager.shoulAddOperand("x")
		}catch {
//			An error is thrown if it is not appropriate to do so
			handleThrown(error)
		}
	}
	
	@IBAction func tappedDivisionButton(_ sender: UIButton){
		do{
			try operationManager.shoulAddOperand("÷")
		}catch {
			handleThrown(error)
		}
	}

    @IBAction func tappedEqualButton(_ sender: UIButton) {
			do{
        try operationManager.showEndResult()
			}catch{
				handleThrown(error)
			}
			
    }
  
  @IBAction func didTapResetButton(_ sender: UIButton){
    self.operationManager.reset()
  }
  
//	Method for handling thrown error
	private func handleThrown(_ error: Error){
		switch error{
		case OperationError.NotAllowedToIncludOperand(let message):
//			Alerts the user by showing an alert view
			alertUserWith(message: message)
		case OperationError.NotEnoughtElements(let message):
			alertUserWith(message: message)
		case OperationError.NotCompleteOperation(let message):
			alertUserWith(message: message)
    case OperationError.zeroDivisionNotPossible:
      alertUserWith(message: "Sorry its not possible to divide by zero!!")
		default: alertUserWith(message: "Unknown error")
		}
	}
	
//	Method for instantiating an alert view with custom message
	private func alertUserWith(message: String){
		let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
		alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
		self.present(alertVC, animated: true, completion: nil)
	}

}

