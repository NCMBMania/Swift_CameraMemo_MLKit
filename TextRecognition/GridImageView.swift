//
//  GridImageView.swift
//  TextRecognition
//
//  Created by Atsushi on 2021/09/03.
//

import SwiftUI
import NCMB

struct GridImageView: View {
    @State private var imageData: Data? = .init(capacity:0)
    @State var memo: NCMBObject? = nil
    @State private var isShowing = false

    var body: some View {
        GeometryReader { geometry in
            if imageData?.count ?? 0 > 0 {
                Image(uiImage: UIImage(data: imageData!)!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.width)
                    .clipped()
            } else {
                Rectangle().fill(Color.clear)
            }
        }.onAppear() {
            loadImage()
        }.onTapGesture {
            isShowing = true
        }.fullScreenCover(isPresented: $isShowing) {
            ModalView(isActive: $isShowing, memo: memo!, imageData: imageData!)
        }

    }

    func loadImage() {
        if let fileName : String = self.memo?["fileName"] {
            let file : NCMBFile = NCMBFile(fileName: fileName)
            let result = file.fetch()
            switch result {
                case let .success(data):
                    self.imageData = data
                case let .failure(error):
                    print(error)
            }
        }
    }
}
