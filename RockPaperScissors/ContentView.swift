//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by DJ on 9/7/22.
//

import SwiftUI
//tornado = rock// flame = paper// bolt = scissors

struct Blue: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .shadow(color: .teal, radius: 5)
            .foregroundColor(.purple)
            .frame(maxWidth: 300)
            .padding(.vertical, 20)
            .background(.thickMaterial)
            .background(Color.orange)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Blue())
    }
}

struct ContentView: View {
    var moves = ["tornado", "flame", "bolt"]
    var choices = ["flame", "bolt", "tornado"]
    @State private var currentChoice = Int.random(in: 0...2)
    @State private var win = Bool.random()
    @State private var rounds = 0
    @State private var score = 0
    let gameOver = "Time is up!"
    @State private var showingGameOver = false
    let instructions = "Here We Go!"
    @State private var notSeenInstructions = true

    var body: some View {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [.blue, .red, .green, .purple, .yellow, .blue]), center: .center, startRadius: 0, endRadius: 900)
                    .ignoresSafeArea()
                VStack(spacing: 30) {
                Spacer()
                Group {
                    Text("Your score: \(score)")
                        HStack(spacing: 1) {
                        Text("Computer chose: ")
                        Image(systemName: choices[currentChoice])
                        }
                        .font(.title)
                    if win == true {
                        Text("You need to WIN to score")
                    } else {
                        Text("You need to LOSE to score")
                    }
                     
                        HStack(spacing: 20) {
                            HStack(spacing: 3) {
                                Image(systemName: "tornado")
                                Text("beats")
                                Image(systemName: "bolt")
                            }
                            HStack(spacing: 3) {
                                Image(systemName: "flame")
                                Text("beats")
                                Image(systemName: "tornado")
                            }
                            HStack(spacing: 3) {
                                Image(systemName: "bolt")
                                Text("beats")
                                Image(systemName: "flame")
                            }
                        }      
                        .foregroundColor(.white)
                }
                .frame(maxWidth: 300)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                Spacer()
                Text("Choose your weapon")
                HStack(spacing: 20) {
                    ForEach(0..<3) { number in
                        Button {
                            if number == 0 {
                                tappedTornado()
                            } else if number == 1 {
                                tappedFlame()
                            } else if number == 2 {
                                tappedBolt()
                            }
                        } label: {
                            Image(systemName: moves[number])
                        }
                    }
                    }
                .titleStyle()
                Spacer()
                }
        }
        .alert(gameOver, isPresented: $showingGameOver) {
            Button("Play again", action: gameIsOver)
        } message: {
            Text("Your Final Score is : \(score)")
        }
        .alert(instructions, isPresented: $notSeenInstructions) {
            Button("I'm ready!", action: gameIsOver)
        } message: {
            Text("You ever heard of Rock, Paper, Scissors? Well this is Tornado, Fire, Lightning! You get 10 rounds to get the highest score you can, but pay attention. Good Luck!")
        }
    }

    func round() {
        win.toggle()
        rounds += 1
        currentChoice = Int.random(in: 0...2)
    }

    func tappedTornado() {
        if choices[currentChoice] == "bolt" && win == true {
            score += 1
        } else if choices[currentChoice] == "flame" && win == false {
            score += 1
        } else {
            score -= 1
        }
        round()
        if rounds >= 10 {
            showingGameOver = true
        }
    }

    func tappedFlame() {
        if choices[currentChoice] == "tornado" && win == true {
            score += 1
        } else if choices[currentChoice] == "bolt" && win == false {
            score += 1
        } else {
            score -= 1
        }
        round()
        if rounds >= 10 {
            showingGameOver = true
        }
    }

    func tappedBolt() {
        if choices[currentChoice] == "flame" && win == true {
            score += 1
        } else if choices[currentChoice] == "tornado" && win == false {
            score += 1
        } else {
            score -= 1
        }
        round()
        if rounds >= 10 {
            showingGameOver = true
        }
    }

   func gameIsOver() {
       rounds = 0
       score = 0
       win.toggle()
       notSeenInstructions = false
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
