//
//  TestViewResult.swift
//  Learning App
//
//  Created by Quevin Bambasi on 4/22/23.
//

import SwiftUI

struct TestViewResult: View {
    @EnvironmentObject var model: ContentModel
    
    var correctAnswersCount: Int
    
    var resultHeading:String {
        guard model.currentModule != nil else {
            return ""
        }
        
        let pct = Double(correctAnswersCount)/Double(model.currentModule!.test.questions.count)
        
        if pct > 0.5 { return "Awesome!" }
        else if pct > 0.2 { return "Doing great!" }
        else { return "Keep learning." }
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(resultHeading)
                .font(.title)
            
            Spacer()
            
            Text("You got \(correctAnswersCount) out of \(model.currentModule?.test.questions.count ?? 0) questions")
            
            Spacer()
            
            CustomButton(executeButtonAction: {model.path.removeLast(model.path.count)}, customText: "Complete", bgColor: .green, txtColor: .white)
            
            Spacer()
            
        }
    }
}

struct TestViewResult_Previews: PreviewProvider {
    static var previews: some View {
        TestViewResult(correctAnswersCount: 0)
            .environmentObject(ContentModel())
    }
}
