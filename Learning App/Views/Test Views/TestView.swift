//
//  TestView.swift
//  Learning App
//
//  Created by Quevin Bambasi on 4/22/23.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var model: ContentModel
    @State var selectedAnswerIndex: Int?
    @State var btnColor = Color.white
    @State var isSubmitted = false
    @State var showResults = false
    @State var correctAnswersCount = 0
    var moduleId: Int?
    
    var questionId: Int {
        return model.currentQuestion?.id ?? 0
    }
    
    var totalQuestions: Int {
        return model.currentModule?.test.questions.count ?? 0
    }
    
    var body: some View {
        if showResults == false {
            VStack(alignment: .leading) {
                Text("Question \(model.currentQuestionIndex + 1) of \(totalQuestions)")
                
                TextViewCode()
                
                if let question = model.currentQuestion {
                    ForEach(0..<question.answers.count, id: \.self) { index in
                        CustomButton(executeButtonAction: {selectedAnswerIndex = index}, customText: model.currentQuestion?.answers[index] ?? "", bgColor: getBgColor(selectedAnswerIndex ?? 0, index), txtColor: .black)
                            .fontWeight(.thin)
                            .disabled(isSubmitted)
                    }
                }
                
                CustomButton(executeButtonAction: {checkSubmitStatus(selectedAnswerIndex ?? 0)}, customText: "Submit", bgColor: .green, txtColor: .white)
                    .padding(.top, 20)
                    .bold()
            }
            .padding()
            .navigationTitle("\(model.currentModule?.category ?? "") Test")
            .onAppear {
                model.beginModule(moduleId ?? 0)
                model.beginTest(questionId)
            }
        }
        else if showResults == true {
            TestViewResult(correctAnswersCount: correctAnswersCount)
        }
        else {
            ProgressView()
        }
    }
    
    func getBgColor(_ selectedAnswerIndex: Int, _ index: Int) -> Color {
        if isSubmitted == false {
            if index == selectedAnswerIndex && self.selectedAnswerIndex != nil {
                return .gray
            }
            else {
                return .white
            }
        }
        else {
            if index == selectedAnswerIndex && index == model.currentQuestion?.correctIndex {
                return .green
            }
            else if index == selectedAnswerIndex && index != model.currentQuestion?.correctIndex {
                return .red
            }
            else if index == model.currentQuestion?.correctIndex {
                return .green
            }
            else {
                return .white
            }
        }
    }
    
    func checkSubmitStatus(_ selectedAnswerIndex: Int) {
        if isSubmitted == false {
            isSubmitted = true
            
            if selectedAnswerIndex == model.currentQuestion?.correctIndex {
                correctAnswersCount += 1
            }
        }
        else {
            if model.currentQuestionIndex + 1 == model.currentModule?.test.questions.count {
                showResults = true
            }
            else {
                model.nextQuestion()
                
                isSubmitted = false
                self.selectedAnswerIndex = nil
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(moduleId: 0)
            .environmentObject(ContentModel())
    }
}
