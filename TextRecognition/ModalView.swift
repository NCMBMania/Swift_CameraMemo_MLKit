//
//  ModalView.swift
//  TextRecognition
//
//  Created by Atsushi on 2021/09/03.
//

import SwiftUI
import NCMB

struct ModalView: View {
    @Binding var isActive: Bool
    @State var memo: NCMBObject
    @State var imageData: Data

    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                GeometryReader { geometry in
                    Image(uiImage: UIImage(data: imageData)!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                }
                if let text: String = memo["text"] {
                    Text(text).padding()
                }
                Button("閉じる") {
                    isActive = false
                }
                Spacer()
            }
            Spacer()
        }
        .padding()
        .background(Color(.black))
    }
}
