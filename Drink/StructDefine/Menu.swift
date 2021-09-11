//
//  Menu.swift
//  Drink
//
//  Created by Dennis Lin on 2021/8/23.
//

import Foundation

struct MenuCommon{
    
    static let apiKey = "keyVepZ3n9zks6GMH"
    static let menu1str = "https://api.airtable.com/v0/appH1U9dQUNHP9UoJ/Menu1?sort[][field]=num"
    static let menu2str = "https://api.airtable.com/v0/appH1U9dQUNHP9UoJ/Menu2?sort[][field]=num"
    static let menu3str = "https://api.airtable.com/v0/appH1U9dQUNHP9UoJ/Menu3?sort[][field]=num"
    static let menu4str = "https://api.airtable.com/v0/appH1U9dQUNHP9UoJ/Menu4?sort[][field]=num"
    static let menu5str = "https://api.airtable.com/v0/appH1U9dQUNHP9UoJ/Menu5?sort[][field]=num"
    
}


let flavorDefines = ["找好茶", "找奶茶", "找口感", "找新鮮", "紅茶拿鐵"]

struct MenuResponse: Codable{
    
    let records: [Record]
    
    
}


struct Record: Codable{
    
    let id: String
    let fields: Field
    
    struct Field: Codable{
        let item: String
        let lPrice: Int
        let mPrice: Int
    }
}
