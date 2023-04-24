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
                    Group {
                        NavigationLink(value: AppView.contentViewDetail(lesson.id)) {
                            ZStack(alignment: .leading) {
                                RectangleCard()
                                
                                HStack(spacing: 30) {
                                    Text(String(lesson.id + 1))
                                        .padding(.leading)
                                        .padding(.vertical, 20)
                                    
                                    VStack(alignment: .leading) {
                                        Text(lesson.title)
                                            .bold()
                                        Text(lesson.duration)
                                            .foregroundColor(.gray)
                                    }
                                }
                                .foregroundColor(.black)
                            }
                            .padding(.vertical, 5)
                        }
                    }
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
