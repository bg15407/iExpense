//
//  ContentView.swift
//  iExpense
//
//  Created by Gayan Kalinga on 5/23/21.
//

import SwiftUI

class User: ObservableObject{
    @Published var firstName = "Gayan"
    @Published var lastName = "Kalinga"
}

struct ContentView: View {
    @ObservedObject var user = User()
    
    var body: some View {
        VStack{
            Text("Your Name is \(user.firstName) \(user.lastName)")
            
            TextField("First Name ", text: $user.firstName)
            TextField("Last Name", text: $user.lastName)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
