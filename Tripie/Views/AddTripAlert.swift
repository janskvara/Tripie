//
//  AddTripAlert.swift
//  Tripie
//
//  Created by janoskvara on 12/17/21.
//


import SwiftUI

struct AddTripAlert: View {
    
    let screenSize = UIScreen.main.bounds
    var title: String = ""
    @Binding var isShown: Bool
    @Binding var text: String
    var onDone: (String) -> Void = { _ in }
    var onCancel: () -> Void = { }
    
    
    var body: some View {
    
        VStack(spacing: 20) {
            Text(title)
                .font(.headline)
            Spacer()
            TextField("Name of the trip", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Spacer()
            HStack(spacing: 20) {
                Button("Cancel") {
                    self.isShown = false
                    self.onCancel()
                    self.text = ""
                }
                .foregroundColor(.red)
                Spacer()
                Button("Create") {
                    self.isShown = false
                    self.onDone(self.text)
                    self.text = ""
                }

            }
            .padding(.horizontal, 15)
        }
        .padding()
        .frame(width: screenSize.width * 0.7, height: screenSize.height * 0.25)
        .background(Color(#colorLiteral(red: 0.9268686175, green: 0.9416290522, blue: 0.9456014037, alpha: 1)))
        .cornerRadius(20)
        //.clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray, lineWidth: 1)
        )
        .offset(y: isShown ? 0 : screenSize.height)
        .animation(.spring())
        //.shadow(color: Color(#colorLiteral(red: 0.8596749902, green: 0.854565084, blue: 0.8636032343, alpha: 1)), radius: 6, x: -9, y: -9)

    }
}

struct AddTripAlert_Previews: PreviewProvider {
    static var previews: some View {
        AddTripAlert(title: "Add Item", isShown: .constant(true), text: .constant(""))
    }
}
