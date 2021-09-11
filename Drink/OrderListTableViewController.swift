//
//  OrderListTableViewController.swift
//  Drink
//
//  Created by Dennis Lin on 2021/9/1.
//

import UIKit

class OrderListTableViewController: UITableViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var totalCountLabel: UILabel!
    var orderLists = [DrinkInfo]()
    var waitIndicatior: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.addTarget(self, action: #selector(closeKeyboard), for: .editingDidEndOnExit)

    }

    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
        updatePrice()
        
       
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return orderLists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(OrderListTableViewCell.self)", for: indexPath)
        as! OrderListTableViewCell
        // Configure the cell...
        
        let item = orderLists[indexPath.row]
        cell.priceLabel.text = item.price.description + "元"
        cell.countLabel.text =  "x" + item.count.description
        cell.itemLabel.text = item.drinkItem.description
        cell.iceLabel.text = item.iceSelect
        cell.sugarLabel.text = item.sugarSelect
        cell.sizeLabel.text = item.sizeSelect
        return cell
    }
    

    @IBAction func sendToOrderList(_ sender: Any) {
        
        //no drink in list
        guard orderLists.count != 0 else {
            let alertController = UIAlertController(title: "錯誤", message: "尚未點餐", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "確認", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        //no order name in list
        guard let text = nameTextField.text,
              text.isEmpty == false else {
            let alertController = UIAlertController(title: "錯誤", message: "尚未輸入訂購者名字", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "確認", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        //show waiting indiactior
        waitIndicatior = UIActivityIndicatorView(style: .large)
        waitIndicatior!.frame = CGRect(x: view.center.x, y: view.center.y, width: 50, height: 50)
        waitIndicatior!.startAnimating()
       self.view.addSubview(waitIndicatior!)
        
        
        if let url = URL(string: OrderCommon.orderstr){
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("Bearer \(MenuCommon.apiKey)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            var response = OrderResponse(records: [OrderRecords]())
         
            
           //add all drink to list
            for order in orderLists {
                response.records.append(OrderRecords(fields: OrderField(orderName: nameTextField.text!, drinkItem: order.drinkItem, price: order.price, count: order.count, iceSelect: order.iceSelect, sugarSelect: order.sugarSelect, sizeSelect: order.sizeSelect)))
            }

            
            
            let dtatbody = response
            let encoder = JSONEncoder()
            let data = try?encoder.encode(dtatbody)
            request.httpBody = data

            URLSession.shared.dataTask(with: request) { data, response, error in
                let decoder = JSONDecoder()
                if let data = data{
                    do {
                        let postResponse =  try decoder.decode(OrderResponse.self, from: data)
                        print(postResponse)
                       
                      
                        DispatchQueue.main.async {
                            if let waitIndiactor = self.waitIndicatior{
                                waitIndiactor.stopAnimating()
                            }
                            let alertController = UIAlertController(title: "成功", message: "成功點餐", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "確認", style: .default, handler: nil)
                            alertController.addAction(okAction)
                            
                            self.present(alertController, animated: true, completion: nil)
                        }


                    } catch  {
                        print(error)
                    }




                }
            }.resume()

        }
    }
    
    //end text view edit
    @IBAction func tapping(_ sender: Any) {
        print("tabb")
        self.view.endEditing(true)
    }
    
    @objc func closeKeyboard() {
        self.view.endEditing(true)
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            orderLists.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            updatePrice()
        }
    }
   
    func updatePrice() {
        
        var totalCount = 0
        var totalPrice = 0
        
        for order in orderLists {
            
            totalCount += order.count
            totalPrice += order.price
        }
        
        totalPriceLabel.text = totalPrice.description + "元"
        totalCountLabel.text = totalCount.description + "杯"
        
    }

}

