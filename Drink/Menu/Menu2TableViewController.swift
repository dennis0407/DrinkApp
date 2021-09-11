//
//  Menu1TableViewController.swift
//  Drink
//
//  Created by Dennis Lin on 2021/8/24.
//

import UIKit

class Menu2TableViewController: UITableViewController {
    var menu: MenuResponse?
    var loadIndicatior: UIActivityIndicatorView?
    var drinks = [Record]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(#function) menu 1 load")
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
        if let url = URL(string: MenuCommon.menu2str){
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

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
