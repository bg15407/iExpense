//
//  ContentView.swift
//  iExpense
//
//  Created by Gayan Kalinga on 5/23/21.
//

import SwiftUI

//iExpense App
struct ExpenseItem: Identifiable, Codable{
    var id = UUID()
    var name: String
    var type: String
    var amount: Int
}

class Expenses: ObservableObject{
    @Published var items = [ExpenseItem](){
        //Saving Data
        didSet{
            let encoder = JSONEncoder()
            if let encodedData = try? encoder.encode(items){
                UserDefaults.standard.set(encodedData, forKey: "SavedExpenseItem")
            }
        }
    }
    
    //Loading Saved Data
    init(){
        if let items = UserDefaults.standard.data(forKey: "SavedExpenseItem"){
            let decoder = JSONDecoder()
            
            if let decodedData = try? decoder.decode([ExpenseItem].self, from: items){
                self.items = decodedData
                return
            }
        }
        items = []
    }
}

struct ContentView: View{
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpenseView = false
    
    var body: some View{
        NavigationView{
            VStack{
                List{
                    ForEach(expenses.items){ item in
                        HStack{
                            Text("\(item.name)")
                            Spacer()
                            VStack{
                                Text("\(item.type)")
                                Text("$\(item.amount)")
                            }
                        }
                    }
                    .onDelete(perform: removeItem)
                }
            }
            .navigationTitle("iExpenses")
            .navigationBarItems(leading: EditButton()
                ,trailing:
                Button(action: {
                    showingAddExpenseView.toggle()
                }) {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $showingAddExpenseView){
                    AddExpenseView(expenses: self.expenses)
                }
)
        }
    }
    
    func removeItem(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
}



//-----//
//Theory
//Storing Complex Data in User Defaults using Codable
//struct User: Codable{
//    var firstName: String
//    var lastName: String
//}
//
//struct ContentView: View{
//    @State private var user = User(firstName: "Gayan", lastName: "Kalinga")
//
//    var body: some View{
//        VStack {
//            Text("\(user.firstName) \(user.lastName)")
//
//            Button("Save User"){
//                let encoder = JSONEncoder()
//
//                if let data = try? encoder.encode(user){
//                    UserDefaults.standard.set(data, forKey: "UserData")
//                }
//            }
//        }
//    }
//}

//Storing Simple data in User Defaults
//struct ContentView: View{
//    @State private var count = UserDefaults.standard.integer(forKey: "CountKey")
//
//    var body: some View{
//        VStack{
//            Text("Count is now \(count)")
//
//            Button("Count up"){
//                count += 1
//                UserDefaults.standard.set(count, forKey: "CountKey")
//            }
//        }
//    }
//}

//Deleting an item from a list
//struct ContentView: View{
//    @State private var numbers = [Int]()
//    @State private var currentNumber = 1
//
//    var body: some View{
//        NavigationView {
//            VStack{
//                List{
//                    ForEach(numbers, id: \.self){
//                        Text("\($0)")
//                    }
//                    .onDelete(perform: removeItem)
//                }
//
//                Button("Add Number"){
//                    numbers.append(self.currentNumber)
//                    currentNumber += 1
//                }
//            }
//            .navigationBarItems(leading: EditButton())
//        }
//    }
//
//    func removeItem(at offsets: IndexSet){
//        numbers.remove(atOffsets: offsets)
//    }
//}


//Using @Environment to access presentation mode & dismiss()
//struct SecondView: View{
//    @Environment(\.presentationMode) var presentationMode
//    var name: String
//
//
//    var body: some View{
//        VStack{
//            Text("Hello, \(name) you are now in the second View")
//            Button("dismiss"){
//                presentationMode.wrappedValue.dismiss()
//            }
//        }
//
//    }
//}
//
//
//struct ContentView: View {
//    @State private var showSheet = false
//
//    var body: some View {
//        VStack{
//            Text("I m the First View")
//
//            Button("Show Second View"){
//                showSheet.toggle()
//            }
//            .sheet(isPresented: $showSheet){
//                SecondView(name: "Gayan")
//            }
//        }
//
//    }
//}


//Classes Sharing Data

//class User: ObservableObject{
//    @Published var firstName = "Gayan"
//    @Published var lastName = "Kalinga"
//}
//
//struct ContentView: View {
//    @ObservedObject var user = User()
//
//    var body: some View {
//        VStack{
//            Text("Your Name is \(user.firstName) \(user.lastName)")
//
//            TextField("First Name ", text: $user.firstName)
//            TextField("Last Name", text: $user.lastName)
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
