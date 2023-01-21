//
//  ContentView.swift
//  NewCarCustomiser
//
//  Created by Akbar, Abdullah (RCH) on 19/01/2023.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @State var starterCars = StarterCars()
    @State private var selectedCar: Int = 0 {
        didSet {
            if selectedCar >= starterCars.cars.count {
                selectedCar = 0
            }
        }
    }
    @State private var exhaustPackage = false
    @State private var tiresPackage = false
    @State private var enginePackage = false
    @State private var NOSPackage = false
    @State private var remainingFunds = 1000
    
    var exhaustPackageEnabled: Bool {
        return exhaustPackage ? true: remainingFunds >= 500 ? true: false
    }
    
    var tiresPackageEnabled: Bool {
        return tiresPackage ? true: remainingFunds >= 500 ? true: false
    }
    
    var enginePackageEnabled: Bool {
        return enginePackage ? true: remainingFunds >= 500 ? true: false
    }
    
    var NOSPackageEnabled: Bool {
        return NOSPackage ? true: remainingFunds >= 1000 ? true: false

    }





    
    var body: some View {
        let exhaustPackageBinding = Binding<Bool> (
            get: {self.exhaustPackage},
            set: { newValue in
                self.exhaustPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].topSpeed += 5
                    remainingFunds -= 500
                } else {
                    starterCars.cars[selectedCar].topSpeed -= 5
                    remainingFunds += 500
                }
            }
        )
        
        let tiresPackageBinding = Binding<Bool> (
            get: {self.tiresPackage},
            set: {newValue in self.tiresPackage = newValue;
                if newValue == true {
                    starterCars.cars[selectedCar].handling += 3
                    remainingFunds -= 500
                } else{
                    starterCars.cars[selectedCar].handling -= 3
                    remainingFunds += 500
                    }
            }
            )
        
        let enginePackageBinding = Binding<Bool> (
            get: {self.enginePackage},
            set: {newValue in self.enginePackage = newValue;
                if newValue == true {
                    starterCars.cars[selectedCar].topSpeed += 3
                    starterCars.cars[selectedCar].acceleration -= 2.0
                    remainingFunds -= 500
                } else{
                    remainingFunds += 500
                    starterCars.cars[selectedCar].topSpeed -= 3
                    starterCars.cars[selectedCar].acceleration += 2.0
                    }
            }
            )
        
        let NOSPackageBinding = Binding<Bool> (
            get: {self.NOSPackage},
            set: {newValue in self.NOSPackage = newValue;
                if newValue == true {
                    starterCars.cars[selectedCar].topSpeed += 10
                    starterCars.cars[selectedCar].acceleration -= 3
                    remainingFunds -= 1000
                } else{
                    starterCars.cars[selectedCar].topSpeed -= 10
                    starterCars.cars[selectedCar].acceleration += 3
                    remainingFunds += 1000

                    }
            }
            )
            
            
            
        Form {
            VStack(alignment: .leading, spacing: 20) {
                Text(starterCars.cars[selectedCar].displayStats())
                Button("Next Car", action: {
                    selectedCar += 1
                    resetDisplay()
                })
            }
            Section {
                Toggle("Exhaust Package (Cost: 500)", isOn: exhaustPackageBinding)
                    .disabled(!exhaustPackageEnabled)
                Toggle("Tires Package (Cost: 500)", isOn: tiresPackageBinding)
                    .disabled(!exhaustPackageEnabled)
                Toggle("Engine Package (Cost: 500)", isOn: enginePackageBinding)
                    .disabled(!enginePackageEnabled)
                Toggle("NOS Package (Cost: 1000)", isOn: NOSPackageBinding)
                    .disabled(!NOSPackageEnabled)
            }
        }
        Text("Remaining Funds: \(remainingFunds)")
            .foregroundColor(.red)
            .baselineOffset(20)
    }
    func resetDisplay() {
        remainingFunds = 1000
        exhaustPackage = false
        tiresPackage = false
        enginePackage = false
        NOSPackage = false
        starterCars = StarterCars()
    }
}


   




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

