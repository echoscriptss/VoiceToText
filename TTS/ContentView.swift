//
//  ContentView.swift
//  TTS
//
//  Created by Yogesh on 4/18/24.
//

import SwiftUI
import AVFoundation
import AVKit
import NaturalLanguage

struct ContentView: View {
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var isRecording = false
    @ObservedObject var objSpeech = SpeechRecognizer()
    @State private var profileText1 = "Enter your bio"
    @State private var profileText2 = "Enter your bio"

    @FocusState private var focusedField: FocusField?
    @State var currentSelectedField: Int = -1
   
    enum FocusField {
        case field1, field2
    }

    var body: some View {
        VStack{
            TextEditor(text: $profileText1)
                .focused($focusedField, equals: .field1)
                .onChange(of: focusedField) { newValue in
                    //                    currentSelectedField = newValue
                    if newValue == .field1 {
                        currentSelectedField = 1
                    }
                }
            
                .padding()
                .lineSpacing(10)
                .border(.black, width: 1)
                .multilineTextAlignment(.leading)
                .padding()
            
            
            TextEditor(text: $profileText2)
                .focused($focusedField, equals: .field2)
                .onChange(of: focusedField) { newValue in
                    if newValue == .field2 {
                        currentSelectedField = 2
                    }
                }
            
            Button("Press") {
                startScrum()
            }
        }
        .onChange(of: speechRecognizer.spokenWords) { newValue in
            // This closure will be called whenever data.text changes
            if currentSelectedField == 1 {
                profileText1.append(contentsOf: " \(newValue)")
            } else {
                profileText2.append(contentsOf: " \(newValue)")
            }
            speechRecognizer.spokenWords = ""
        }
    }
    
    private func startScrum() {
        speechRecognizer.resetTranscript()
        speechRecognizer.startTranscribing()
        isRecording = true
    }
    
    private func endScrum() {
        speechRecognizer.stopTranscribing()
    }
}


#Preview {
    ContentView()
}
