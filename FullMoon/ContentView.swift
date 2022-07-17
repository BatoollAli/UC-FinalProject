//
//  ContentView.swift
//  FullMoon
//
//  Created by Batool Hussain on 09/07/2022.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationView{
            Home()
                .navigationTitle("Full Moon")
                .navigationBarTitleDisplayMode(.inline)
                .font(.system(size: 50))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

