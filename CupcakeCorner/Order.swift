//
//  Order.swift
//  CupcakeCorner
//
//  Created by Izabela Marcinkowska on 2024-10-14.
//

import Foundation

@Observable
class Order: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
    }
    
    init() {
        loadAddressFromDefaults()
    }
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    struct Address: Codable {
        var name = ""
        var streetAddress = ""
        var city = ""
        var zip = ""
    }
    var address = Address()
    
    func loadAddressFromDefaults() {
        if let data = UserDefaults.standard.data(forKey: "Address") {
            let decoder = JSONDecoder()
            
            if let savedAdress = try? decoder.decode(Address.self, from: data) {
                address = savedAdress
            }
        }
    }
    
    func saveAddressToDefaults() {
        let encoder = JSONEncoder()
        
        if let data = try? encoder.encode(address) {
            UserDefaults.standard.set(data, forKey: "Address")
        }
    }
        
    
    
    var hasValidStreet: Bool {
        return address.streetAddress.count >= 5
    }
    
    var hasValidName: Bool {
        return address.name.count >= 3 && address.name.count <= 30
    }
    
    var hasValidCity: Bool {
            return address.city.count >= 3 && address.city.count <= 30
        }

        var hasValidZip: Bool {
            return address.zip.count == 5
        }
    
    var cost: Decimal {
        var cost = Decimal(quantity) * 2
        
        cost += Decimal(quantity)
        
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        return cost
    }
}
