//
//  OverViewController.swift
//  Money Keeper
//
//  Created by Zach Zhong on 10/07/2017.
//  Copyright © 2017 Zach Zhong. All rights reserved.
//

import UIKit
import Charts

class OverViewController: UIViewController, IValueFormatter, ChartViewDelegate {
    
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var balanceLabel: UILabel!
    
    var summaryVC = SummaryViewController()
    var transactions = [Transaction]()
    let moneyModel = MoneyModel()
    var balance: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pieChartView.delegate = self
        pieChartView.noDataText = "Add at least one transaction to see the report"
        pieChartView.noDataFont = UIFont(name: "Helvetica Neue", size: 15)
        
       summaryVC = tabBarController?.viewControllers![2]as! SummaryViewController
        
        
        loadData()
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        transactions = summaryVC.transactions
        balance = moneyModel.getBalance(transactions: transactions)
        
        if balance! > 0 {
            
            balanceLabel.textColor =  UIColor.green
            self.balanceLabel.text = String(format: "+$%.2f", self.balance!)
            
        } else if balance! < 0 {
            
            balanceLabel.textColor = UIColor.red
            balance = balance! * -1
            self.balanceLabel.text = String(format: "-$%.2f", self.balance!)
            
        } else {
            
            balanceLabel.textColor = UIColor.gray
            self.balanceLabel.text = String(format: "$%.2f", self.balance!)
            
        }
        
        
        loadChartData()
        
        
    }
    
    
    func loadData () {
        
        let defaults = UserDefaults.standard
        if let decoded = defaults.object(forKey: "TransactionData") as? Data{
            let decodedTransactions = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [Transaction]
            transactions = decodedTransactions
            summaryVC.transactions = decodedTransactions
        }
        
    }
    
    
    func loadChartData(){
        
        if transactions.count >= 1 {
        let pieChartData = configureChart()
        pieChartData.setValueFormatter(self)
        pieChartView.data = pieChartData
        pieChartView.animate(yAxisDuration: 1)
        }
        
    }
    
    func configureChart() -> ChartData{
        
        let chartDescripton = Description()
        chartDescripton.text = nil
        pieChartView.chartDescription = chartDescripton
        pieChartView.usePercentValuesEnabled = true
        pieChartView.holeRadiusPercent = 0.25
        pieChartView.transparentCircleRadiusPercent = 0.3
        pieChartView.centerText = "Spendings by\n Category"
        
        
        let myLegend = pieChartView.legend
        myLegend.horizontalAlignment = Legend.HorizontalAlignment(rawValue: 1)!
        
        let chartDataSet = PieChartDataSet(values: getChartData(), label: nil)
        chartDataSet.entryLabelColor = UIColor.gray
        chartDataSet.setColors(getRandomColor(count: 30), alpha: 0.5)
        let chartData = PieChartData(dataSet: chartDataSet)
        return chartData
        
        
    }

    
    private func getChartData() -> [PieChartDataEntry]{
        
        //TODO: If the category occupies less than 3%, then sum them up to another category
        //TODO: If you click on part of the chart, it will show you the specific detail assocaited with the value

        var dataEntries: [PieChartDataEntry] = []
        var smallDataEntries = [PieChartDataEntry]()
        var smallData = [AnyObject]()
        let transactionsByCategory = moneyModel.getTransactionsByCategory(isExpense: true, transactions: transactions)
        
        
        for category in transactionsByCategory{
            
            if category["Percentage"]as! Double! <= 0.05  {
                let smallDict = category as AnyObject
                let smallDataEntry = PieChartDataEntry(value: category["Amount"] as! Double, label: category["Category Name"] as? String, data: smallDict)
                
                smallDataEntries.append(smallDataEntry)
                
            } else {
                
                let dataentry = PieChartDataEntry(value: category["Amount"] as! Double, label: category["Category Name"] as? String)
                
                dataEntries.append(dataentry)
                
            }
  
        }
        
        
        var smallEntryTotalValue = 0.0
        var smallEntryLabel = ""

        for entry in smallDataEntries {
            
            let index = smallDataEntries.index(of: entry)
            smallEntryTotalValue += entry.value
            smallEntryLabel +=  entry.label!
            
            smallData.append(entry.data!)
            
            if index != smallDataEntries.count - 1 {
                
                smallEntryLabel += ", "
            }
            
            
        }

        if smallDataEntries.count > 0 {
        dataEntries.append(PieChartDataEntry(value: smallEntryTotalValue, label: smallEntryLabel, data: smallData as AnyObject))
        }
        
        
        return dataEntries
        
    }
    
    
    
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        
        return String(format: "%.2f%%", value)
        
        
    }
    
    func getRandomColor(count:Int) -> [UIColor]{
        
        var colorArray = [UIColor]()
        
        for _ in 1 ... count {
            
            let randomRed:CGFloat = CGFloat(drand48())
            
            let randomGreen:CGFloat = CGFloat(drand48())
            
            let randomBlue:CGFloat = CGFloat(drand48())
            
            colorArray.append(UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0))
            
        }
        
        return colorArray
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
        let pieEntry = entry as! PieChartDataEntry
        
        
        //Display a different message for the data that got combined
        if let pieEntryData = pieEntry.data as? [[String:Any]] {
            
            var combinedMessage = "\n"
            
            for index in 0...pieEntryData.count - 1 {
               
               combinedMessage += pieEntryData[index]["Category Name"] as! String
               combinedMessage += ": "
               combinedMessage += "$\(pieEntryData[index]["Amount"] as! Double) which takes up " + String(format: "%.2f%%", pieEntryData[index]["Percentage"] as! Double * 100)  + "\n"
            
                
            }
            
            let alert = UIAlertController(title: "Categories with less than 5%", message: combinedMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)

            
            
        } else {
        
        let alert = UIAlertController(title: "\(pieEntry.label!)", message: "You spent $\(pieEntry.value) on \(pieEntry.label!)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        
        }
        
    }
    
    
    
    
}
