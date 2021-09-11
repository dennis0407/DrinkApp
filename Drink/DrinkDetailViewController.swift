//
//  DrinkDetailViewController.swift
//  Drink
//
//  Created by Dennis Lin on 2021/8/30.
//

import UIKit

class DrinkDetailViewController: UIViewController {

    var drinkInfo: DrinkPrice?
    var totalPrice = 0
    var totalCount = 0
    @IBOutlet weak var sizeSegment: UISegmentedControl!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var sugarSegment: UISegmentedControl!
    @IBOutlet weak var iceSegment: UISegmentedControl!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var countTextField: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        priceLabel.text = String(totalPrice)
        itemLabel.text = drinkInfo?.drinkItem.description
        sizeSegment.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 20)], for: .normal)
        iceSegment.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 20)], for: .normal)
        sugarSegment.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 20)], for: .normal)
        sizeSegment.selectedSegmentTintColor = UIColor(red: 0 / 255, green: 209 / 255, blue: 204 / 255, alpha: 1)
        iceSegment.selectedSegmentTintColor = UIColor(red: 204 / 255, green: 255 / 255, blue: 255 / 255, alpha: 1)
        sugarSegment.selectedSegmentTintColor = UIColor(red: 153 / 255, green: 255 / 255, blue: 204 / 255, alpha: 1)
        
    }
    

    @IBAction func wrriteCount(_ sender: Any) {
        updatePrice()
       
    }
    @IBAction func changeSize(_ sender: Any) {
        updatePrice()
    }
    
    
    @IBAction func cancelOrder(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addToOrderList(_ sender: Any) {
        
        //total price is wrong
        guard priceLabel.text != String(0) else {
            let alertController = UIAlertController(title: "錯誤", message: "輸入錯誤", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "確認", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        
        //Send drink drink order to order list
        if let vc = self.tabBarController?.viewControllers?[1] as? OrderListTableViewController,
        //   let vc = nav.tab
           let drinkInfo = drinkInfo
           {
            
            
            let order = DrinkInfo(drinkItem: drinkInfo.drinkItem, price: totalPrice, count: totalCount, iceSelect: iceDefines[iceSegment.selectedSegmentIndex], sugarSelect: sugarDefines[sugarSegment.selectedSegmentIndex], sizeSelect: sizeDefines[sizeSegment.selectedSegmentIndex])
            vc.orderLists.append(order)
            
            let alertController = UIAlertController(title: "成功", message: "成功點餐", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "確認", style: .default) {  uialeraction in
                self.navigationController?.popViewController(animated: true)
            }
           
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func updatePrice(){
        
        guard let countText =  countTextField.text,
              !countText.isEmpty,
              let drinkInfo = drinkInfo
        else{  return  }
         
        //large price or medium price
        let price = sizeSegment.selectedSegmentIndex == 0 ? drinkInfo.lPrice: drinkInfo.mPrice
        let count = Int(countText) ?? 0
        totalCount = count
        totalPrice = price * count
        priceLabel.text = String(price * count)
    }
}

extension DrinkDetailViewController: UITextFieldDelegate{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       self.view.endEditing(true)
        updatePrice()
    }
}
