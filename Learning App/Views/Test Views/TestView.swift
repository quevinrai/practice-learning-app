//
//  TestView.swift
//  Learning App
//
//  Created by Quevin Bambasi on 4/22/23.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var model: ContentModel
    var moduleId: Int?
    
    var questionId: Int {
        return model.currentQuestion?.id ?? 0
    }
    
    var totalQuestions: Int {
        return model.currentModule?.test.questions.count ?? 0
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Question \(model.currentQuestionIndex + 1) of \(totalQuestions)")
            TextViewCode()
        }
        .padding()
        .navigationTitle("\(model.currentModule?.category ?? "") Test")
        .onAppear {
            model.beginModule(moduleId ?? 0)
            model.beginTest(questionId)
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(moduleId: 0)
            .environmentObject(ContentModel())
    }
}
