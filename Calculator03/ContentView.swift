//
//  ContentView.swift
//  Calculator03
//
//  Created by javier machuca on 24-06-23.
//

import SwiftUI

struct ContentView: View {
    @State private var numberOnScreen: Double = 0
    @State private var previousNumber: Double = 0
    @State private var performingMath = false
    @State private var operation = 0
    let buttons = ["AC", "±", "%", "÷",
                   "7", "8", "9", "x",
                   "4", "5", "6", "-",
                   "1", "2", "3", "+",
                   "",  "0", ".", "="]
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 20) {
            Text(String(numberOnScreen))
                            .font(.largeTitle)
                            .padding()
        }
        .padding()
        ForEach(0..<5) { row in
            HStack(spacing: 20) {
//                Text(String(row))
                ForEach(0..<4) {
                    column in Button(action: {
                        let buttonValue = self.buttons[row * 4 + column]
                        self.buttonPressed(buttonValue: buttonValue)
                    }) {
                        if row == 4 && column == 0 {
                            Text("")
                        } else if row == 4 && column == 1 {
                            self.createButton(title: self.buttons[row * 4 + column],
                                              row: row, column: column, width: 150)
                        } else {
                            self.createButton(title: self.buttons[row * 4 + column],
                                              row: row, column: column, width: 75)
                        }
                    
                    }
                }
            }
            .padding(.all, 5)
        }
    }
    
    private func createButton(title: String, row: Int, column:Int, width: CGFloat) -> some View {
        Text(title)
            .font(.title)
            .frame(width: width, height: 75)
            .background(Color(.lightGray))
            .foregroundColor(.black)
            .cornerRadius(37.5)
    }
    
    private func buttonPressed(buttonValue: String) {
            let buttonNumber = Double(buttonValue)
            
            if let number = buttonNumber {
                if performingMath {
                    numberOnScreen = number
                    performingMath = false
                } else {
                    numberOnScreen = numberOnScreen * 10 + number
                }
            } else {
                switch buttonValue {
                case "AC":
                    numberOnScreen = 0
                    previousNumber = 0
                    operation = 0
                case "±":
                    numberOnScreen = numberOnScreen * -1
                case "%":
                    numberOnScreen = numberOnScreen * 0.01
                case "÷":
                    operation = 4
                    performingMath = true
                    previousNumber = numberOnScreen
                case "x":
                    operation = 3
                    performingMath = true
                    previousNumber = numberOnScreen
                case "-":
                    operation = 2
                    performingMath = true
                    previousNumber = numberOnScreen
                case "+":
                    operation = 1
                    performingMath = true
                    previousNumber = numberOnScreen
                case "=":
                    switch operation {
                    case 1:
                        numberOnScreen += previousNumber
                    case 2:
                        numberOnScreen = previousNumber - numberOnScreen
                    case 3:
                        numberOnScreen *= previousNumber
                    case 4:
                        numberOnScreen = previousNumber / numberOnScreen
                    default:
                        numberOnScreen = 0
                    }
                default:
                    break
                }
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
