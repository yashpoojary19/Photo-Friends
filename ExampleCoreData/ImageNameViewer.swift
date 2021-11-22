//
//  ImageNameViewer.swift
//  ExampleCoreData
//
//  Created by Yash Poojary on 22/11/21.
//

import SwiftUI

struct ImageNameView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var name: String
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            TextField("Enter a name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.words)
                .padding()
            
            Button("Done") {
                
                if name.isEmpty {
                    showAlert = true
                }
                else {
                    presentationMode.wrappedValue.dismiss()
                }
                
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Need a name"), message: Text("Please enter a name"), dismissButton: .default(Text("Okay")))
        }
    }
    
}
