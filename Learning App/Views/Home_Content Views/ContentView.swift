//
//  ContentView.swift
//  Learning App
//
//  Created by Quevin Bambasi on 4/22/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Learn Swift")
                .font(.title)
                .bold()
                .padding(.horizontal)
            
            ScrollView {
                ForEach(model.modules[0].content.lessons) { lesson in
                    NavigationLink(value: AppView.contentViewDetail) {
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
                .padding()
            }
            
            
//            NavigationLink(value: AppView.contentViewDetail) {
//                Text("Content View")
//            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ContentModel())
    }
}
