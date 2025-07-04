//
//  MonsterDetailView.swift
//  DND
//
//  Created by Parimal Devi on 04/07/25.
//

import SwiftUI

struct MonsterDetailView: View {
    @State var monster: Monster
    @State private var monsterDetailVM = MonsterDetailViewModel()
    var body: some View {
        VStack {
            Text(monster.name)
                .font(.largeTitle)
                .bold()
                .padding(.bottom)
            HStack {
                VStack (alignment: .leading) {
                    Text("type").bold()
                    Text(monsterDetailVM.type.capitalized)
                        .padding(.bottom)
                    
                    Text("alignment").bold()
                    Text(monsterDetailVM.alignment.capitalized)
                        .padding(.bottom)
                }
                Spacer()
                VStack (alignment: .leading) {
                    Text("size").bold()
                    Text(monsterDetailVM.size.capitalized)
                        .padding(.bottom)
                    
                    Text("hit points").bold()
                    Text("\(monsterDetailVM.hitPoints)")
                        .padding(.bottom)
                }
                
            }
            .font(.title)
            
            AsyncImage(url: URL(string: monsterDetailVM.imageURL)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(radius: 16)
                } else if phase.image != nil {
                    Image(systemName: "questionmark.square.dashed")
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(radius: 16)
                } else {
                    ProgressView()
                        .tint(.pink)
                        .scaleEffect(4)
                        .frame(maxWidth: .infinity)
                        .frame(height: 250)
                }
            }
            Spacer()
        }
        .padding(.horizontal)
        .task {
            monsterDetailVM.urlString = monsterDetailVM.baseURL + monster.url
            await monsterDetailVM.getData()
        }
    }
}

#Preview {
    MonsterDetailView(monster: Monster(
        index: "adult-gold-dragon",
        name: "Adult Gold Dragon",
        url: "/api/2014/monsters/adult-gold-dragon"
    )
    )
}
