//
//  ContentView.swift
//  TextRecognition
//
//  Created by Atsushi on 2021/09/02.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            InputView()
                .tabItem {
                    VStack {
                        Image(systemName: "photo")
                        Text("Photo")
                    }
            }.tag(1)
            ImageView()
                .tabItem {
                    VStack {
                        Image(systemName: "rectangle.grid.2x2")
                        Text("Photos")
                    }
            }.tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
