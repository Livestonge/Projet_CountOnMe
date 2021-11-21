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
			  operationManager = OperationManager()
			  NotificationCenter.default.addObserver(self,
																						 selector: #selector(updateView),
																						 name: .dataDidChange,
																						 object: nil)
			  
    }
    
	
	@objc private func updateView(){
		
		textView.text = operationManager.elements.joined(separator: "")
		
	}
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
			  operationManager?.add(element: numberText)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
			do{
				try operationManager.shoulAddOperand("+")
			}catch {
				handleThrown(error)
			}
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
			do{
				try operationManager.shoulAddOperand("-")
			}catch {
				handleThrown(error)
			}
    }
	
	@IBAction func tappedMultiplicationButton(_ sender: UIButton){
		do{
			try operationManager.shoulAddOperand("x")
		}catch {
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
				try operationManager.calculate()
			}catch{
				handleThrown(error)
			}
			
    }
	
	private func handleThrown(_ error: Error){
		switch error{
		case OperationError.NotAllowedToIncludOperand(let message):
			alertUserWith(message: message)
		case OperationError.NotEnoughtElements(let message):
			alertUserWith(message: message)
		case OperationError.NotCompleteOperation(let message):
			alertUserWith(message: message)
		default: alertUserWith(message: "Unknow error")
		}
	}
	
	private func alertUserWith(message: String){
		let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
		alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
		self.present(alertVC, animated: true, completion: nil)
	}

}

