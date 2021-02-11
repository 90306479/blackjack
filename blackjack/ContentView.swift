//
//  ContentView.swift
//  blackjack
//
//  Created by 90306479 on 1/31/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var win = ""
    @State var playerCard1 = "cardbacks"
    @State var playerCard2 = "cardbacks"
    @State var playerCard3 = "cardbacks"
    @State var playerCard4 = "cardbacks"
    @State var playerCard5 = "cardbacks"
    @State var hitLabel = " Play "
    @State var dealerScore = "??"
    @State var playerScore = 0
    @State var deal = -1
    @State var round = 0
    @State var totalScore = 10
    @State var ovalColor = 0
    
    var body: some View {
        
        ZStack{
            
            Image("redback")
            .resizable()
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            
            
            VStack {
                
                
                Text("❂BLACKJACK❂")
                    .font(.system(size: 50))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .padding(.top, 35)
                    .padding(.bottom, 25)
                
                
                //win or lose oval
                ZStack{
                    
                    if ovalColor == 0 {
                     RoundedRectangle(cornerRadius: 30).fill(Color.white).frame(width: 260, height: 50)
                    } else if ovalColor == 1 {
                     RoundedRectangle(cornerRadius: 30).fill(Color.green).frame(width: 260, height: 50)
                    } else if ovalColor == 2 {
                     RoundedRectangle(cornerRadius: 30).fill(Color.red).frame(width: 260, height: 50)
                    } else {
                     RoundedRectangle(cornerRadius: 30).fill(Color.black).frame(width: 260, height: 50)
                    }
                    
                    Text(win)
                        .font(.title3)
                        .padding()
                        .foregroundColor(.white)
                        .cornerRadius(30)
                    
                    if (playerScore == 0){
                        Text("click play to start")
                            .foregroundColor(.black)
                    }
                }
                
                Spacer()
                
                
                //player cards
                HStack {
                    
                    
                    Image(playerCard1)
                        .resizable()
                        .frame(width: 70, height: 110)
                    Image(playerCard2)
                        .resizable()
                        .frame(width: 70, height: 110)
                    Image(playerCard3)
                        .resizable()
                        .frame(width: 70, height: 110)
                    Image(playerCard4)
                        .resizable()
                        .frame(width: 70, height: 110)
                    Image(playerCard5)
                        .resizable()
                        .frame(width: 70, height: 110)
                    
                }
                
                Spacer()
                
                
                //hit and stay buttons
                HStack {
                    
                    Spacer()
                    
                    //hit button
                    Button(action: {
                        
                        if (deal == -1){
                            
                        playSound(sound: "click", type: "mp3")
                            
                        round+=1
                        win = winLose()
                        hitLabel = "  Hit  "
                        var value = 0
                        let rand = Int.random(in: 2...14)
                        if rand == 14 {
                            value = 11
                        } else if rand > 9 {
                            value = 10
                        } else {
                            value = rand
                        }
                        
                        
                        if (round == 1) {
                            playerCard1 = ("card" + String(rand))
                        } else if (round == 2) {
                            playerCard2 = ("card" + String(rand))
                        } else if (round == 3) {
                            playerCard3 = ("card" + String(rand))
                        } else if (round == 4) {
                            playerCard4 = ("card" + String(rand))
                        } else if (round == 5) {
                            playerCard5 = ("card" + String(rand))
                        }
                        
                        playerScore+=value
                        
                        if playerScore > 21 {
                            deal = -2
                            totalScore-=1
                            win = winLose()
                        }
                        
                        if playerScore == 21 {
                            deal = -3
                            totalScore+=2
                            win = winLose()
                        }
                    }
                        
                    }, label: {
                        Text(hitLabel)
                            .padding(10)
                            .font(.title2)
                            .foregroundColor(Color.black)
                            .background(Color.white)
                            .cornerRadius(10)
                    })
                    
                    Spacer()
                    
                    //stay button
                    Button(action: {
                        
                        if deal == -1 {
                            
                            playSound(sound: "click", type: "mp3")
                            
                            deal = Int.random(in: 17...26)
                            dealerScore = String(deal)
                            
                            if (deal > 21) {
                                totalScore+=1
                            } else if (deal > playerScore){
                                totalScore-=1
                            } else if (deal < playerScore){
                                totalScore+=1
                            }
                            
                            win = winLose()
                            
                        }
                        
                    }, label: {
                        Text(" Stay ")
                            .padding(10)
                            .font(.title2)
                            .foregroundColor(Color.black)
                            .background(Color.white)
                            .cornerRadius(10)
                    })
                    
                    Spacer()
                
                }
                
                
                //player and dealer scores
                HStack {
                    Spacer()
                    Text("Your score: " + String(playerScore))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Spacer()
                    Text("Dealer score: " + dealerScore)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.top, 50)
                .padding(.bottom, 40)
                
                
                //money left
                HStack {
                    
                    Spacer()
                    
                    Text("Money left: $" + String(totalScore))
                        .font(.title3)
                        .foregroundColor(.white)
                    
                    
                    Button(action:{
                        playSound(sound: "moneyBills", type: "mp3")
                        totalScore += 5
                    }, label: {
                        Text("Bank loan")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .padding(.horizontal, 38)
                    })
                    
                    
                }
                
                
                //play again button
                Button(action: {
                    
                    playSound(sound: "click", type: "mp3")
                    
                    playerCard1 = "cardbacks"
                    playerCard2 = "cardbacks"
                    playerCard3 = "cardbacks"
                    playerCard4 = "cardbacks"
                    playerCard5 = "cardbacks"
                    playerScore = 0
                    dealerScore = "??"
                    round = 0
                    deal = -1
                    hitLabel = " Play "
                    ovalColor = 0
                    win = "hit play to start"
                    
                }, label: {
                    Text("Play Again")
                        .font(.title2)
                        .padding(10)
                        .foregroundColor(Color.black)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(40)
                })
                
                
            
        }
        
    }
        
        
}
    

    
    func winLose() -> String {
        
        
        if (deal == -1) {
            return("  ")
        } else if (deal == -2) {
            ovalColor = 2
            playSound(sound: "lose", type: "mp3")
            return("bust!! you lose!!")
        } else if (deal == -3) {
            ovalColor = 1
            playSound(sound: "doubleWin", type: "mp3")
            return("perfect 21!! you win double!!")
        } else if (deal > 21) {
            ovalColor = 1
            playSound(sound: "money", type: "mp3")
            return("dealer bust!! you win!!")
        } else if (deal == playerScore){
            ovalColor = 3
            playSound(sound: "tie", type: "mp3")
            return("tie!!")
        } else if (deal > playerScore) {
            ovalColor = 2
            playSound(sound: "lose", type: "mp3")
            return("you lose!!")
        } else {
            ovalColor = 1
            playSound(sound: "money", type: "mp3")
            return("you win!!")
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
