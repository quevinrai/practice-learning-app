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
    
    var module: Module {
        if let moduleId = moduleId {
            model.currentModuleIndex = moduleId
            return model.modules[moduleId]
        }
        else {
            return Module()
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                ForEach(module.content.lessons) { lesson in
                    ContentViewRow(lesson: lesson)
                }
                .padding()
            }
        }
        .navigationTitle("Learn Swift")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(moduleId: 0)
            .environmentObject(ContentModel())
    }
}
