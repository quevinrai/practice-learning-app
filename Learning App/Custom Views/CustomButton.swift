//
//  CustomButton.swift
//  Learning App
//
//  Created by Quevin Bambasi on 4/25/23.
//

import SwiftUI

struct CustomButton: View {
    @EnvironmentObject var model: ContentModel
    var executeButtonAction: () -> ()
    var customText: String
    
    var body: some View {
        Button {
            executeButtonAction()
        } label: {
            ZStack {
                RectangleCard(color: Color.green)
                    .frame(height: 48)
                
                Text(customText)
                    .foregroundColor(.white)
                    .bold()
            }
        }
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(executeButtonAction: {}, customText: "")
            .environmentObject(ContentModel())
    }
}
