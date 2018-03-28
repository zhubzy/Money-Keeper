//
//  KeepAcountViewController.swift
//  Money Keeper
//
//  Created by Zach Zhong on 7/3/17.
//  Copyright © 2017 Zach Zhong. All rights reserved.
//

import UIKit

class KeepAcountViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var receiptPhotoView: UIImageView!
    
    @IBOutlet weak var amountTextField: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var notes: UITextField!
    
    @IBOutlet weak var categoryTextField: UITextField!
    
    
    var summaryViewController : SummaryViewController? = nil
    
    
    //Determines if the transaction is an expense or income
    @IBOutlet weak var currentTransactionState: UISegmentedControl!

    @IBOutlet weak var receiptView: UIStackView!{
    didSet {
        
    
    }
    }
    
    var datePicker : UIDatePicker!
    var pickerView = UIPickerView()
    var currentDatePicked : Date?
    
    //Controls expense or income, true if expense
    var currentStateIsExpense : Bool?
    
    var amountInDouble: Double?
    var categories = Transaction().categories
    var incomeCategories = Transaction().incomeCategories
    let categoryVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "categoryVC") as! CategoryViewController
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        receiptView.isHidden = true
        
        categoryVC.categories = categories
        categoryVC.incomeCategories = incomeCategories
        
        currentStateIsExpense = true
        categoryVC.isExpense = true
        
        
        //Initalize the text field
        categoryTextField.delegate = categoryVC
        amountTextField.delegate = self
        amountTextField.keyboardType = UIKeyboardType.decimalPad
        pickUpDate(dateTextField)
        setUpPickerView()
        
        
        //Make a UITapGesture Recognizer to dismiss keyboard
        let keyboardDismissRecognizer = UITapGestureRecognizer(target: self, action: #selector (dismissKeyboard))
        
        //Attach it the the function
        scrollView.addGestureRecognizer(keyboardDismissRecognizer)
        
        
        
        
    }
    
    
    @IBAction func confirmTapped(_ sender: Any) {
        
        let newTransacation = Transaction()
        
        let summaryViewController = tabBarController?.viewControllers![2]as! SummaryViewController
        
        
        //Messages for no amount left
        let errorAlert = UIAlertController(title: "Error", message: "", preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        //Messages for sucessfully added
        let successfulAlert = UIAlertController(title: "Success", message: "", preferredStyle: .alert)
        successfulAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (alertAction) in
            
            self.switchToSummaryTab()
            self.resetAll()
            
        }))
        
        
        
        
        //If amount text field is not empty
        if Double(amountTextField.text!) == 0 {
            
            errorAlert.message = "Amount cannot be 0"
            present(errorAlert, animated: true, completion: nil)
            
            
        } else if amountTextField.text == "" {
            
            errorAlert.message = "Please enter an amount"
            present(errorAlert, animated: true, completion: nil)
            
            
        } else if dateTextField.text == "" {
            
            errorAlert.message = "Please enter a date"
            present(errorAlert, animated: true, completion: nil)
            
        } else if categoryTextField.text == "" {
            
            errorAlert.message = "Please pick a category"
            present(errorAlert, animated: true, completion: nil)
            
            
        } else {
            
            //Save the amount
            newTransacation.amountToDisplay = amountTextField.text
            newTransacation.amount = amountInDouble!
            
            //Save the date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy"
            newTransacation.year = Int(dateFormatter.string(from: currentDatePicked!))
            dateFormatter.dateFormat = "dd"
            newTransacation.date = Int(dateFormatter.string(from: currentDatePicked!))
            dateFormatter.dateFormat = "MM"
            newTransacation.month = Int(dateFormatter.string(from: currentDatePicked!))
            newTransacation.dateToDisplay = dateTextField.text
            
            
            //Save the category
            if currentStateIsExpense == true{
                newTransacation.isExpense = true
            } else {
                newTransacation.isExpense = false
            }
            newTransacation.currentCategory = categoryTextField.text!
            
            
            //Save the note
            if notes.text != "" {
                
                newTransacation.note = notes.text!
                
            }
            
            //Save the receipt image, if there is any
            if let receiptImage = receiptPhotoView.image {
                
                newTransacation.receiptImage = receiptImage
                
            }
            
            
            //Save and update the overview page
            summaryViewController.loadViewIfNeeded()
            summaryViewController.transactions.insert(newTransacation, at: 0)
            
            
            
            //Display the success message
            successfulAlert.message = "Successfully added"
            present(successfulAlert, animated: true, completion: nil)
        }
        
        
        
        
        
        
    }
    
    func switchToSummaryTab(){
        
        //TODO: Add some animation
        tabBarController!.selectedIndex = 2
        
    }
    
    
    
    
    
    
    //Called when a tap happens outside the keyboard
    func dismissKeyboard(){
        
        //Disable editing therefore dismissing the keyboard
        view.endEditing(true)
    }
    
    
    
    
    
    
    //Format the number text field after each edit
    func textFieldDidEndEditing(_ textField: UITextField) {
        
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
                
                amountTextField.text = ""
            }
            
        }
        
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if amountTextField.text != "" {
            
            if let actualText = amountInDouble {
            amountTextField.text = String(format: "%.0f", actualText)
            }
            
        }
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if currentStateIsExpense == true {
            
            return categories.count
            
        } else {
            
            return incomeCategories.count
            
        }
        
        
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        if currentStateIsExpense == true {
            
            categoryTextField.text = categories [row]
            
        } else {
            
            categoryTextField.text = incomeCategories [row]
            
        }
        
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let imagepickerView = ImagePickerView()
        
        if currentStateIsExpense == true {
            return imagepickerView.makeview(category: categories, row: row, width: pickerView.bounds.width)
        } else {
            return imagepickerView.makeview(category: incomeCategories, row: row, width: pickerView.bounds.width)
        }
        
        
        
        
        
    }
    
    func setUpPickerView() {
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        
        
        
        //TODO: Apply style
        let newCategoryButton = UIBarButtonItem(title: "Add New Category", style: .plain, target: self, action: #selector(addNewCategory))
        let deleteCategoryButton = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(removeCategory))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(cancelClick))
        
        
        categoryTextField.inputView = pickerView
        categoryTextField.inputAccessoryView = toolBar
        toolBar.setItems([deleteCategoryButton, spaceButton, newCategoryButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        
        
        
        
    }
    
    
    func removeCategory() {
        
        
        
        let removeAlert = UIAlertController(title: "Warning", message: "", preferredStyle: .alert)
        
        removeAlert.addAction(UIAlertAction(title: "Yes!", style: .destructive, handler: { (alertAction) in
            
            if self.currentStateIsExpense == true {
                self.categories.remove(at: self.pickerView.selectedRow(inComponent: 0))
                self.categoryVC.categories = self.categories
            } else {
                self.incomeCategories.remove(at: self.pickerView.selectedRow(inComponent: 0))
                self.categoryVC.incomeCategories = self.incomeCategories
            }
            self.pickerView.reloadAllComponents()
            self.categoryTextField.text = ""
            self.dismissKeyboard()
            
            
            
        }))
        
        removeAlert.addAction(UIAlertAction(title: "Never mind!", style: .cancel, handler: nil))
        
        
        if currentStateIsExpense == true {
            
            removeAlert.message = "You are about to remove \"\(categories[pickerView.selectedRow(inComponent: 0)])\""
            
        } else {
            
            removeAlert.message = "You are about to remove \"\(incomeCategories[pickerView.selectedRow(inComponent: 0)])\""
            
        }
        
        present(removeAlert, animated: true, completion: nil)
        
        
        
    }
    
    func addNewCategory () {
        
        
        present(categoryVC, animated: true, completion: nil)
        
    }
    
    func pickUpDate(_ textField : UITextField){
        
        // DatePicker
        datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: view.frame.size.width, height: 216))
        datePicker.backgroundColor = UIColor.white
        datePicker.datePickerMode = UIDatePickerMode.date
        datePicker.addTarget(self, action: #selector(valueChanged(sender:)), for: .valueChanged)
        textField.inputView = datePicker
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    
    // MARK:- Button Done and Cancel
    func doneClick() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .medium
        dateFormatter1.dateFormat =  ""
        dateFormatter1.timeStyle = .none
        dateTextField.text = dateFormatter1.string(from: datePicker.date)
        currentDatePicked = datePicker.date
        dismissKeyboard()
        
    }
    func cancelClick() {
        dateTextField.resignFirstResponder()
        dismissKeyboard()
        
    }
    @IBAction func currentStateChanged(_ sender: Any) {
        
        
        
        switch currentTransactionState.selectedSegmentIndex {
            
        case 0:
            
            dismissKeyboard()
            print("expense")
            currentStateIsExpense = true
            categoryVC.isExpense = true
            setUpPickerView()
            categoryTextField.text = ""
            
        case 1:
            
            dismissKeyboard()
            print("income")
            currentStateIsExpense = false
            categoryVC.isExpense = false
            setUpPickerView()
            categoryTextField.text = ""
            
            
        default:
            break
            
        }
        
    }
    
    
    func resetAll() {
        
        amountTextField.text = ""
        dateTextField.text = ""
        categoryTextField.text = ""
        notes.text = ""
        currentTransactionState.selectedSegmentIndex = 0
        currentStateIsExpense = true
        receiptView.isHidden = true
        receiptPhotoView.image = nil
        button1.isHidden = false
    }
    
 
    
    @IBAction func importReceiptPhoto(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        
        if (sender as! UIButton).tag == 1 {
            imagePicker.sourceType = .camera
        } else {
            
            imagePicker.sourceType = .photoLibrary
            
        }
        
        
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true, completion: nil)
        
        
        
        
        
    }
    
    @IBOutlet weak var button1: UIButton!
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
           receiptPhotoView.addConstraint(NSLayoutConstraint(item: receiptPhotoView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300))
            receiptPhotoView.image = image
            receiptView.isHidden = false
            
            button1.isHidden = true
            
            
        } else  {
            
            //Eroor Message
            
            
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func deleteRecipt(_ sender: Any) {
        
        let alert = UIAlertController(title: "Delete Receipt", message: "Are you sure you want to delete the receipt image?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (action) in
            self.receiptPhotoView.image = nil
            self.receiptView.isHidden = true
            self.button1.isHidden = false
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        present(alert, animated: true, completion: nil)
    }
    
    
    func valueChanged(sender: UIDatePicker)
        
    {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .medium
        dateFormatter1.dateFormat =  ""
        dateFormatter1.timeStyle = .none
        dateTextField.text = dateFormatter1.string(from: datePicker.date)
        currentDatePicked = datePicker.date
        
    }

    
}





