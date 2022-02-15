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
//        An error is thrown if it is not appropriate to do so
				try operationManager.shoulAddOperand("+")
			}catch let error as OperationError {
        handleThrown(error)
      }catch{}
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
			do{
//				Ask the operationManager to add an substraction sign
//        An error is thrown if it is not appropriate to do so
				try operationManager.shoulAddOperand("-")
			}catch let error as OperationError {
        handleThrown(error)
      }catch{}
    }
	
	@IBAction func tappedMultiplicationButton(_ sender: UIButton){
		do{
//			Ask the operationManager to add an substraction sign
//      An error is thrown if it is not appropriate to do so
			try operationManager.shoulAddOperand("x")
		}catch let error as OperationError {
      handleThrown(error)
    }catch{}
	}
  
	@IBAction func tappedDivisionButton(_ sender: UIButton){
		do{
			try operationManager.shoulAddOperand("÷")
		}catch let error as OperationError {
      handleThrown(error)
    }catch{}
	}

    @IBAction func tappedEqualButton(_ sender: UIButton) {
			do{
        try operationManager.showEndResult()
			}catch let error as OperationError {
				handleThrown(error)
      }catch{}
			
    }
  
  @IBAction func didTapResetButton(_ sender: UIButton){
    self.operationManager.reset()
  }
  
//	Method for handling thrown error
	private func handleThrown(_ error: OperationError){
    //      Alerts the user by showing an alert view
    alertUserWith(message: error.description)
	}
	
//	Method for instantiating an alert view with custom message
	private func alertUserWith(message: String){
		let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
		alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
		self.present(alertVC, animated: true, completion: nil)
	}

}

