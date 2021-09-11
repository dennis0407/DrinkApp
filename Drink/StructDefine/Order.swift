//
//  Order.swift
//  Drink
//
//  Created by Dennis Lin on 2021/8/30.
//

import Foundation

struct OrderCommon{
    
    static let apiKey = "keyVepZ3n9zks6GMH"
    static let orderstr = "https://api.airtable.com/v0/appH1U9dQUNHP9UoJ/Order"
    
}

struct DrinkPrice: Codable{
    
    var drinkItem: String
    var mPrice: Int
    var lPrice: Int
}

struct DrinkInfo: Codable{
    
    var drinkItem: String
    var price: Int
    var count: Int
    var iceSelect: String
    var sugarSelect: String
    var sizeSelect: String
}

struct OrderRecords: Codable{
    
    var fields: OrderField
    
}

struct OrderResponse: Codable{
    
    var records: [OrderRecords]
    
    
}

struct OrderField: Codable{
   
   var orderName: String
   var drinkItem: String
   var price: Int
   var count: Int
   var iceSelect: String
   var sugarSelect: String
   var sizeSelect: String
   
}

let sizeDefines = ["大杯", "中杯"]

let sugarDefines = ["無糖", "微糖", "半糖", "少糖", "正常"]

let iceDefines = ["去冰", "微冰", "少冰", "正常"]

