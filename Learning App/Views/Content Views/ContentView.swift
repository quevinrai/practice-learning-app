//
//  ContentView.swift
//  Learning App
//
//  Created by Quevin Bambasi on 4/22/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: ContentModel
    var moduleId: Int?
    
    var body: some View {
        VStack(alignment: .leading) {
            if let currentModule = model.currentModule {
                ScrollView {
                    ForEach(currentModule.content.lessons) { lesson in
                        ContentViewRow(lesson: lesson)
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Learn Swift")
        .onAppear {
            model.beginModule(moduleId ?? 0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(moduleId: 0)
            .environmentObject(ContentModel())
    }
}
