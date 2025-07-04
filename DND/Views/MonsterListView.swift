//
//  MonsterListView.swift
//  DND
//
//  Created by Parimal Devi on 04/07/25.
//

import SwiftUI

struct MonsterListView: View {
    @State private var monstersVM = MonstersViewModel()
    var body: some View {
        NavigationStack {
            ZStack {
                List(monstersVM.monsters) { monster in
                    NavigationLink {
                         MonsterDetailView(monster: monster)
                    } label: {
                        Text(monster.name)
                            .font(.title2)
                    }
                    
                }
                .listStyle(.plain)
                
                if monstersVM.isLoading {
                    ProgressView()
                        .tint(.pink)
                        .scaleEffect(4)
                }
            }
            .navigationTitle("Monsters:")
            .toolbar {
                ToolbarItem(placement: .status) {
                    Text("\(monstersVM.monsters.count) Monsters")
                }
            }
        }
        .task {
            await monstersVM.getData()
        }
        
    }
}

#Preview {
    MonsterListView()
}
