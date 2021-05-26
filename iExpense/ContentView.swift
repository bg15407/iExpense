//
//  ContentView.swift
//  iExpense
//
//  Created by Gayan Kalinga on 5/23/21.
//

import SwiftUI

struct SecondView: View{
    @Environment(\.presentationMode) var presentationMode
    var name: String
    
    
    var body: some View{
        VStack{
            Text("Hello, \(name) you are now in the second View")
            Button("dismiss"){
                presentationMode.wrappedValue.dismiss()
            }
        }
        
    }
}


struct ContentView: View {
    @State private var showSheet = false
   
    var body: some View {
        VStack{
            Text("I m the First View")
            
            Button("Show Second View"){
                showSheet.toggle()
            }
            .sheet(isPresented: $showSheet){
                SecondView(name: "Gayan")
            }
        }

    }
}


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
