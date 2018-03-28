//
//  CategoryViewController.swift
//  Money Keeper
//
//  Created by Zach Zhong on 10/07/2017.
//  Copyright © 2017 Zach Zhong. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UITextFieldDelegate{
    @IBOutlet weak var newCategoryTextField: UITextField!
    
    
    var newCategory: String?
    var isExpense: Bool?
    var categories = [String]()
    var incomeCategories = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    
    @IBAction func doneAdding(_ sender: Any) {
        
        let tabBarController = presentingViewController as! UITabBarController
        let keepAcountVC = tabBarController.viewControllers![0] as!KeepAcountViewController
        
        if newCategoryTextField.text != "" {
            
            newCategory = newCategoryTextField.text
            
            
            if isExpense == true{
                
                //Insert the new category and update the text field and row position
                keepAcountVC.categories.insert(newCategory!, at: keepAcountVC.categories.count - 1)
                keepAcountVC.categoryTextField.text = keepAcountVC.categories [categories.count - 1]
                keepAcountVC.pickerView.selectRow(categories.count - 1, inComponent: 0, animated: true)
            } else {
                
                //Insert the new category and update the text field and row position
                keepAcountVC.incomeCategories.insert(newCategory!, at: keepAcountVC.incomeCategories.count - 1)
                 keepAcountVC.categoryTextField.text = keepAcountVC.incomeCategories [incomeCategories.count - 1]
                 keepAcountVC.pickerView.selectRow(incomeCategories.count - 1, inComponent: 0, animated: true)
            }
            
            categories = keepAcountVC.categories
            incomeCategories = keepAcountVC.incomeCategories
            newCategoryTextField.text = ""
            tabBarController.dismiss(animated: true, completion: nil)
            
        } else {
            
            let alert = UIAlertController(title: "Error", message: "No category entered", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            
            present(alert, animated: true, completion: nil)
        }
        
        
    }
    
  
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        let pickerView = textField.inputView as! UIPickerView

        if isExpense == true && textField.text == "" {
            
            textField.text = categories [0]
            pickerView.selectRow(0, inComponent: 0, animated: true)

            
            
        } else if isExpense == false && textField.text == "" {
            
            textField.text = incomeCategories [0]
            pickerView.selectRow(0, inComponent: 0, animated: true)
            
        } else if let index = categories.index(of: textField.text!) {
            
            pickerView.selectRow(index, inComponent: 0, animated: true)
            
        } else if let index = incomeCategories.index(of: textField.text!){
            
            pickerView.selectRow(index, inComponent: 0, animated: true)
            
        }
        
        
       

    }
    
    
    
    
}
