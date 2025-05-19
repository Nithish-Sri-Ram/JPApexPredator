//
//  ContentView.swift
//  JPApexPredators
//
//  Created by Nithish on 19/05/25.
//

// (ctrl + i) To indent stuff (After selecting the area to content)
// Use seperation of concern - describe the data, prepare the data and show the data
// In the vstack - the adding of the contents start from the center and will make up space and move up and down
// in the scroll view - it will directly start from the top and go to the bottom
// Geometry reader - a container view that defines its content as a function of its own size and coordinate space
// The geometry reader is used in the predator detail screen to scale and position the dino info on the screen

import SwiftUI
import MapKit

struct ContentView: View {
    let predators = Predators()
    
    @State var searchText: String = ""
    @State var alphabetical = false
    @State var currentSelection = APType.all
    
    var filteredDinos: [ApexPredator]{
        predators.filter(by: currentSelection)
        predators.sort(by: alphabetical)
        
        return predators.search(for: searchText)
    }
    
    var body: some View {
        NavigationStack{
            List(filteredDinos) { predator in
                NavigationLink{
                    PredatorDetail(predator: predator, position: .camera(
                        MapCamera(
                            centerCoordinate:
                                predator.location,
                            distance: 30000
                        )))
                } label: {
                    HStack {
                        // Dino img
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .shadow(color: .white,radius: 1)
                        
                        VStack(alignment: .leading){
                            // Name
                            Text(predator.name)
                                .fontWeight(.bold)
                            
                            // Type
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 13)
                                .padding(.vertical, 5)
                                .background(predator.type.background)
                                .clipShape(.capsule)
                        }
                    }
                }
            }
            .navigationTitle(Text("Apex Predators"))
            .searchable(text: $searchText)
            .autocorrectionDisabled()
            .animation(.default, value: searchText)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            alphabetical.toggle()
                        }
                    } label: {
                        Image(systemName: alphabetical ? "film" : "textformat")
                            .symbolEffect(.bounce, value: alphabetical)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Filter", selection: $currentSelection.animation()){
                            ForEach(APType.allCases){ type in
                                Label(type.rawValue.capitalized, systemImage: type.icon)
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
