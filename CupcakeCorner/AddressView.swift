//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Izabela Marcinkowska on 2024-10-14.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.address.name)
                TextField("Street Address", text: $order.address.streetAddress)
                TextField("City", text: $order.address.city)
                TextField("Zip", text: $order.address.zip)
                
            }
            
            Section {
                NavigationLink("Check out") {
                    CheckoutView(order: order)
                }
            }
            .disabled(!order.hasValidZip || !order.hasValidCity || !order.hasValidStreet || !order.hasValidName)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear {
            order.saveAddressToDefaults()
        }
    }
}

#Preview {
    AddressView(order: Order())
}
