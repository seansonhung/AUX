//
//  ContentView.swift
//  AUX
//
//  Created by Sean Nguyen on 2020-10-13.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button(action: {
            print("Pressed!")
            }) {
            Image("cow")
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(Color.gray, lineWidth: 4))
                .shadow(radius: 10)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
