//
//  ContentViewRow.swift
//  Learning App
//
//  Created by Quevin Bambasi on 4/22/23.
//

import SwiftUI

struct ContentViewRow: View {
    var lesson: Lesson
    
    var body: some View {
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

struct ContentViewRow_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewRow(lesson: Lesson())
            .environmentObject(ContentModel())
    }
}
