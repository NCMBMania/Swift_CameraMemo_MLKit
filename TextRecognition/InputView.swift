//
//  InputView.swift
//  TextRecognition
//
//  Created by Atsushi on 2021/09/03.
//

import SwiftUI
import MLKit
import AVFoundation
import NCMB

struct InputView: View {
    // イメージピッカーの表示用フラグ
    @State var showingPicker = false
    // 選択した写真が入る
    @State var image: UIImage?
    // 認識したテキストが入る
    @State var recognizeText: String?
    // ML Kitのテキスト認識用オブジェクト
    @State var textRecognizer = TextRecognizer.textRecognizer(options: JapaneseTextRecognizerOptions())
    // アラートのタイトル
    @State var title: String?
    // アラートのメッセージ
    @State var message: String?
    // アラートの表示用フラグ
    @State private var showingAlert = false
    
    var body: some View {
        VStack {
            HStack {
                Button("写真を撮る", action: {
                    showingPicker = true
                })
                Spacer()
                Button("保存する", action: {
                    savePhoto()
                })
                .disabled(image == nil)
            }
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text(recognizeText ?? "")
            }
        }
        .sheet(isPresented: $showingPicker) {
            ImagePickerView(image: $image, sourceType: .library)
        }
        .onChange(of: image, perform: { value in
            getText()
        })
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(title!), message: Text(message!))
        }
    }
    
    // テキスト抽出を行います
    func getText() -> Void {
        if image == nil {
            recognizeText = nil
            return
        }
        let vImage = VisionImage(image: image!)
        vImage.orientation = image!.imageOrientation
        textRecognizer.process(vImage) { result, error in
            guard error == nil, let result = result else {
                // Error handling
                return
            }
            // Recognized text
            recognizeText = result.text
        }
    }
    
    // NCMBへ写真とテキストを保存します
    func savePhoto() -> Void {
        let fileName = "\(UUID()).jpg"
        let file = NCMBFile(fileName: fileName)
        var result = file.save(data: image!.jpegData(compressionQuality: 80)!)
        switch result {
        case .success(_):
            break
        case .failure(_):
            title = "エラー"
            message = "ファイルアップロードでエラーが発生しました"
            showingAlert = true
            return
        }
        let memo = NCMBObject(className: "Memo");
        memo["text"] = recognizeText
        memo["fileName"] = fileName
        result = memo.save()
        switch result {
        case .success(_):
            message = "メモしました"
            title = "保存完了"
            image = nil
            showingAlert = true
            break
        case .failure(_):
            message = "ファイルアップロードでエラーが発生しました"
            title = "エラー"
            showingAlert = true
            break
        }
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView()
    }
}
