//
//  MenuViewController.swift
//  Drink
//
//  Created by Dennis Lin on 2021/8/26.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet var containerViews: [UIView]!
    @IBOutlet weak var menuSegment: UISegmentedControl!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        for containView in containerViews{
            containView.isHidden = true
        }
        containerViews[0].isHidden = false
        setDrinkTitle()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func changeMenu(_ sender: Any) {
        for containView in containerViews{
            containView.isHidden = true
        }
        containerViews[menuSegment.selectedSegmentIndex].isHidden = false
    }
    
    func setDrinkTitle(){
        for num in 0..<menuSegment.numberOfSegments{
            menuSegment.setTitle(flavorDefines[num], forSegmentAt: num)
        }
        
    }
    
   
}



