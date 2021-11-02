//
//  SelectorImage.swift
//  Tripie
//
//  Created by Jakub Kachlík on 24.10.2021.
//
import SwiftUI

struct AimCross: View {
    var body: some View {
        Image(systemName: "plus")
                .font(.title)
    }
}

struct SelectorImage_Previews: PreviewProvider {
    static var previews: some View {
        AimCross()
    }
}
