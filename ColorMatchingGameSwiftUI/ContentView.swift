//
//  ContentView.swift
//  ColorMatchingGameSwiftUI
//
//  Created by ramil on 21.09.2020.
//

import SwiftUI

struct ContentView: View {
    
    @State private var rActual = randomizer()
    @State private var gActual = randomizer()
    @State private var bActual = randomizer()
    
    @State var redSlider: Double
    @State var greenSlider: Double
    @State var blueSlider: Double
    
    @State var showAlert = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Match this Color")
                .font(.largeTitle)
                .bold()
            
            HStack {
                Circle()
                    .fill(Color(red: rActual, green: gActual, blue: bActual))
                    .padding()
                
                Circle()
                    .fill(Color(red: redSlider, green: greenSlider, blue: blueSlider))
                    .padding()
            }
            
            Sliders(value: $redSlider, color: .red, textColor: "Red")
            Sliders(value: $greenSlider, color: .green, textColor: "Green")
            Sliders(value: $blueSlider, color: .blue, textColor: "Blue")
            
            Button(action: {
                self.showAlert = true
            }, label: {
                Text("Submit")
            }).padding(
                EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 24)
            )
            .background(Color(red: rActual, green: gActual, blue: bActual)
                            .cornerRadius(.infinity))
            .foregroundColor(.white)
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("Your performance"), message: Text(stars()))
            })
            
            Button(action: {
                reset()
            }, label: {
                Text("Reset")
            }).padding(
                EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 24)
            )
            .background(Color(red: redSlider, green: greenSlider, blue: blueSlider)
                            .cornerRadius(.infinity))
            .foregroundColor(.white)
        }
    }
    
    static func randomizer() -> Double {
        return Double.random(in: 0..<1)
    }
    
    func stars() -> String {
        let difference = Int(abs((rActual * 255) * (bActual * 2555) * (gActual * 255) - (redSlider * 255) * (greenSlider * 255) * (blueSlider * 255)))
        
        if (difference < 4194304) {
            return "⭐️⭐️⭐️⭐️"
        } else if (difference < 8388608) {
            return "⭐️⭐️⭐️"
        } else if (difference < 12582912) {
            return "⭐️⭐️"
        } else {
            return "⭐️"
        }
    }
    
    func reset() {
        rActual = ContentView.randomizer()
        gActual = ContentView.randomizer()
        bActual = ContentView.randomizer()
        
        redSlider = 0
        greenSlider = 0
        blueSlider = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(redSlider: 0, greenSlider: 0, blueSlider: 0)
    }
}

struct Sliders: View {
    
    @Binding var value: Double
    var color: Color
    var textColor: String
    
    var body: some View {
        VStack {
            Text("\(textColor) (\(Int(value * 255)))")
                .font(.largeTitle)
            Slider(value: $value)
                .accentColor(color)
                .padding()
        }
    }
}
