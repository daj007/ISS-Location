//
//  ContentView.swift
//  ISSLocation
//
//  Created by David Amezcua on 5/16/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ISSPositionViewModel()

    var body: some View {
        ZStack {
            Image("ISS_background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            Rectangle()
                .fill(Color.white.opacity(0.3))
                .edgesIgnoringSafeArea(.all)

            VStack {

                Text("ISS Current Position")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()

                Text(viewModel.position)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                Spacer()
                Image("ISS_noBackground")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .offset(x: viewModel.animateImage ? UIScreen.main.bounds.width / 2 + 100 : -UIScreen.main.bounds.width / 2 - 100, y: 0)
                    .animation(.linear(duration: 2.5), value: viewModel.animateImage)

                Spacer()

                Button(action: {
                    viewModel.fetchISSPosition()
                }) {
                    Text("Refresh")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding()
                }

            }
        }
        .onAppear {
            viewModel.fetchISSPosition()
        }
    }
}

#Preview {
    ContentView()
}
