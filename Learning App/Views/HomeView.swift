//
//  HomeView.swift
//  Learning App
//
//  Created by Quevin Bambasi on 4/20/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        NavigationStack(path: $model.path) {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Get Started")
                        .font(.title)
                        .bold()
                    
                    Text("What do you want to do today?")
                        .font(.caption)
                }
                .padding(.horizontal)
                .padding(.top, 20)
                
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(model.modules) { module in
                            NavigationLink(value: AppView.contentView) {
                                HomeViewRow(image: module.content.image, title: "Learn \(module.category)", description: module.content.description, count: "\(module.content.lessons.count) Lessons", time: module.content.time)
                            }
                            
                            NavigationLink(value: AppView.testView) {
                                HomeViewRow(image: module.test.image, title: "\(module.category) Test", description: module.test.description, count: "\(module.test.questions.count) Lessons", time: module.test.time)
                            }
                        }
                        .foregroundColor(.black)
                    }
                    .padding()
                }
                .navigationDestination(for: AppView.self) { path in
                    switch path {
                        case .contentView: ContentView()
                        case .contentViewDetail: ContentViewDetail()
                        case .testView: TestView()
                        case .testViewResult: TestViewResult()
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
