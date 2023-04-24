//
//  ContentViewDetail.swift
//  Learning App
//
//  Created by Quevin Bambasi on 4/22/23.
//

import SwiftUI

struct ContentViewDetail: View {
    @EnvironmentObject var model: ContentModel
    
    var lessonId: Int?
    
    var lesson: Lesson {
        if let lessonId = lessonId {
            model.currentLessonIndex = lessonId

            return model.modules[model.currentModuleIndex].content.lessons[model.currentLessonIndex]
        }
        else {
            return Lesson()
        }
    }
    
    var body: some View {
        VStack {
            Text("Current Lesson Index: \(model.currentLessonIndex)")
        }
        .navigationTitle(lesson.title)
    }
}

struct ContentViewDetail_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewDetail(lessonId: 0)
            .environmentObject(ContentModel())
    }
}
