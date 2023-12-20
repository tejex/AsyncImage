//
//  ContentView.swift
//  AsyncImageLoading
//
//  Created by Bamlak Deju on 9/5/23.
//

import SwiftUI 

extension Image{
    func imageModifier () -> some View{
        self.resizable()
            .scaledToFit()
    }
    func iconModifier () -> some View{
        self.imageModifier().frame(maxWidth: 128).foregroundColor(.purple);
    }
}

struct ContentView: View {
    private let webAddress: String = "https://credo.academy/credo-academy@3x.png";
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: webAddress), transaction:
                        Transaction(animation:
                                .spring(response: 0.5,
                                        dampingFraction: 0.6,
                                        blendDuration: 0.25)
                        )){
                phase in
                switch phase {
                case .success(let image):
                    image.imageModifier()
                        .transition(.scale)
                case .failure(_):
                    Image(systemName:"ant.circle.fill").iconModifier()
                case .empty:
                    Image(systemName: "photo.circle.fill").iconModifier()
                @unknown default:
                   ProgressView()
                }
            }.padding(40);
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
