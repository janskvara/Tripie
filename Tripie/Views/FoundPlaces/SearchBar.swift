//
//  SearchBar.swift
//  Tripie
//
//  Created by Jakub Kachlík on 24.10.2021.
//
import SwiftUI

struct SearchBar: View {
    @Binding var searchString : String
    var body: some View {
        TextField("Search bar", text: $searchString)
            .padding(10)
            .padding([.leading])
            .background(Color("Search_Background"))
            .cornerRadius(10)
            .padding()    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        Text("undone")
        //SearchBar()
    }
}
