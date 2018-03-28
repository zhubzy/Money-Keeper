//
//  EditViewController.swift
//  Money Keeper
//
//  Created by Zach Zhong on 31/07/2017.
//  Copyright © 2017 Zach Zhong. All rights reserved.
//

import UIKit

class EditViewController: KeepAcountViewController {
    
    var transactionInEdit = Transaction()
    var destinationVC = TransactionDetailViewController()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
     
        
    }
    
    
    override func textFieldDidEndEditing(_ textField: UITextField) {
        if let actualText = amountTextField.text {
            
            
            //Convert the text to double
            let amountDouble = Double(actualText)
            
            //If convertion is successful
            if let actualAmountDouble = amountDouble {
                
                
                
                //Format it to 2 decimal digits and save as double
                let amountInString = String(format: "%.2f", actualAmountDouble)
                amountInDouble = Double(amountInString)
                
                //Format it to 2 decimal digits in string
                amountTextField.text = "$".appending(amountInString)
                
            } else {
                
                amountTextField.text = String(format: "$%.2f",amountInDouble!)
                
            }
            
        }
        
        
        
        
        
        
    }
    override func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            receiptPhotoView.addConstraint(NSLayoutConstraint(item: receiptPhotoView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300))
            receiptPhotoView.image = image
            receiptView.isHidden = false
                        
            
        } else  {
            
            //Eroor Message
            
            
        }
        
        dismiss(animated: true, completion: nil)
        

    }
    
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        textFieldDidEndEditing(amountTextField)
        
        //Save the amount
        transactionInEdit.amountToDisplay = amountTextField.text
        transactionInEdit.amount = amountInDouble!
        
        //Save the date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        transactionInEdit.year = Int(dateFormatter.string(from: datePicker.date))
        dateFormatter.dateFormat = "dd"
        transactionInEdit.date = Int(dateFormatter.string(from: datePicker.date))
        dateFormatter.dateFormat = "MM"
        transactionInEdit.month = Int(dateFormatter.string(from: datePicker.date))
        transactionInEdit.dateToDisplay = dateTextField.text
        
        
        //Save the category
        if currentStateIsExpense == true{
            transactionInEdit.isExpense = true
        } else {
            transactionInEdit.isExpense = false
        }
        transactionInEdit.currentCategory = categoryTextField.text!
        
        
        //Save the note
        if notes.text != "" {
            
            transactionInEdit.note = notes.text!
            
        }
        
        //Save the receipt image, if there is any
        if let receiptImage = receiptPhotoView.image {
            
            transactionInEdit.receiptImage = receiptImage
            
        }

        
        
        
        destinationVC.transaction = transactionInEdit
        
        
        
        
       
        
    }
    
        
}
