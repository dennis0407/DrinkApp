//
//  Menu3TableViewController.swift
//  Drink
//
//  Created by Dennis Lin on 2021/8/30.
//

import UIKit

class Menu3TableViewController: UITableViewController {
    var menu: MenuResponse?
    var drinks = [Record]()
    var loadIndicatior: UIActivityIndicatorView?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(#function) menu  load")
        fetchMenu()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return drinks.count
    }
    
    func fetchMenu(){
        if let url = URL(string: MenuCommon.menu3str){
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer \(MenuCommon.apiKey)", forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                let decoder = JSONDecoder()
                if let data = data{
                    do {
                        let response =  try decoder.decode(MenuResponse.self, from: data)
                        self.drinks = response.records
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        
                    } catch  {
                        print(error)
                    }
                   
                   
                    
                    
                }
            }.resume()
                
            
        }
          
       
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(MenuTableViewCell.self)", for: indexPath)
        as! MenuTableViewCell
        // Configure the cell...
        
        let item = drinks[indexPath.row]
        cell.drinkLabel.text = item.fields.item
        cell.lPriceLabel.text = item.fields.lPrice.description
        cell.mPriceLabel.text = item.fields.mPrice.description
        
        return cell
    }
    

    
    func addLoadIndicator(){
        loadIndicatior = UIActivityIndicatorView(style: .large)
        loadIndicatior!.frame = CGRect(x: view.center.x, y: 100, width: 50, height: 50)
        loadIndicatior!.startAnimating()
       self.view.addSubview(loadIndicatior!)
           
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDrinkDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "goToDrinkDetail"{
            let vc = segue.destination as! DrinkDetailViewController
            if let row = tableView.indexPathForSelectedRow?.row{
                vc.drinkInfo = DrinkPrice(drinkItem: drinks[row].fields.item, mPrice: drinks[row].fields.mPrice, lPrice: drinks[row].fields.lPrice)
                
               
            }
            
        }
    }

}
