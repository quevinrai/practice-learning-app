//
//  ContentViewDetail.swift
//  Learning App
//
//  Created by Quevin Bambasi on 4/22/23.
//

import SwiftUI
import AVKit

struct ContentViewDetail: View {
    @EnvironmentObject var model: ContentModel
    var lessonId: Int?
    
    var body: some View {
        let url = URL(string: Constants.videoHostUrl + (model.currentLesson?.video ?? Lesson().video))
        
        VStack {
            if let url = url {
                VideoPlayer(player: AVPlayer(url: url))
                    .cornerRadius(10)
            }
            
            TextViewCode()
            
            
            if model.hasNextLesson() {

                CustomButton(executeButtonAction: {model.nextLesson()}, customText: "Next Lesson: \(model.currentModule?.content.lessons[model.currentLessonIndex + 1].title ?? "")", bgColor: .green, txtColor: .white)
            }
            else {

                CustomButton(executeButtonAction: {model.path.removeLast(model.path.count)}, customText: "Complete", bgColor: .green, txtColor: .white)
            }
        }
        .padding()
        .navigationTitle(model.currentLesson?.title ?? Lesson().title)
        .onAppear {
            model.beginLesson(lessonId ?? 0)
        }
    }
}

struct ContentViewDetail_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewDetail(lessonId: 0)
            .environmentObject(ContentModel())
    }
}
