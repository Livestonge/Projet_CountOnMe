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
			
			if operationManager?.shoulAddOperand("+") == false {
				let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
				alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
				self.present(alertVC, animated: true, completion: nil)
			}
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
			if operationManager.shoulAddOperand("-") == false {
				let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
				alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
				self.present(alertVC, animated: true, completion: nil)
			}
    }
	
	@IBAction func tappedMultiplicationButton(_ sender: UIButton){
		if operationManager.shoulAddOperand("x") == false {
			let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
			alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
			self.present(alertVC, animated: true, completion: nil)
		}
	}
	
	@IBAction func tappedDivisionButton(_ sender: UIButton){
		if operationManager.shoulAddOperand("÷") == false {
			let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
			alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
			self.present(alertVC, animated: true, completion: nil)
		}
	}

    @IBAction func tappedEqualButton(_ sender: UIButton) {
			guard operationManager.expressionIsCorrect else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
			guard operationManager.expressionHaveEnoughElement else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
			operationManager.calculate()
    }

}

