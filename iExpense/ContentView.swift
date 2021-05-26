//
//  ContentView.swift
//  iExpense
//
//  Created by Gayan Kalinga on 5/23/21.
//

import SwiftUI


struct ContentView: View{
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    var body: some View{
        NavigationView {
            VStack{
                List{
                    ForEach(numbers, id: \.self){
                        Text("\($0)")
                    }
                    .onDelete(perform: removeItem)
                }
                
                Button("Add Number"){
                    numbers.append(self.currentNumber)
                    currentNumber += 1
                }
            }
            .navigationBarItems(leading: EditButton())
        }
    }
    
    func removeItem(at offsets: IndexSet){
        numbers.remove(atOffsets: offsets)
    }
}


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
