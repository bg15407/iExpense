//
//  AddExpenseView.swift
//  iExpense
//
//  Created by Gayan Kalinga on 5/27/21.
//

import SwiftUI

struct AddExpenseView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses: Expenses
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""

    
    let types = ["Personal", "Work"]
    
    var body: some View {
        NavigationView{
            Form{
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type){
                    ForEach(types, id: \.self){
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationTitle("Add New Expense")
            .navigationBarItems(leading:
                Button("Dismiss"){
                    presentationMode.wrappedValue.dismiss()
                },
                trailing:
                Button("Save"){
                    if let actualAmount = Int(self.amount){
                        let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                        self.expenses.items.append(item)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            )
        }
    }
}

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView(expenses: Expenses())
    }
}
