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
    
    var body: some View {
        Text("Test View")
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(moduleId: 0)
            .environmentObject(ContentModel())
    }
}
