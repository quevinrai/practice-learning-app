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
                    Text("What do you want to do today?")
                        .font(.caption)
                }
                .padding(.horizontal)
                
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(model.modules) { module in
                            VStack(spacing: 10){
                                NavigationLink(value: AppView.contentView(module.id)) {
                                    HomeViewRow(image: module.content.image, title: "Learn \(module.category)", description: module.content.description, count: "\(module.content.lessons.count) Lessons", time: module.content.time)
                                }
                                
                                NavigationLink(value: AppView.testView(module.id)) {
                                    HomeViewRow(image: module.test.image, title: "\(module.category) Test", description: module.test.description, count: "\(module.test.questions.count) Lessons", time: module.test.time)
                                }
                            }
                        }
                        .foregroundColor(.black)
                    }
                    .padding()
                }
            }
            .navigationTitle("Get Started")
            .navigationDestination(for: AppView.self) { path in
                switch path {
                    case let .contentView(moduleId): ContentView(moduleId: moduleId)
                    case let .contentViewDetail(lessonId): ContentViewDetail(lessonId: lessonId)
                    case let .testView(moduleId): TestView(moduleId: moduleId)
                    case let .testViewResult(questionId): TestViewResult(questionId: questionId)
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
