//
//  SettingsView.swift
//  RamaNama
//
//  Created by Puneet Teng on 04/09/2022.
//

import SwiftUI

enum Language: String {
    case english = "English"
    case hindi = "Hindi"
    case sanskrit = "Sanskrit"
    case telugu = "Telugu"
}

struct SettingsView: View {
    @Binding var selectedLanguage: Language?
    
    var body: some View {
        VStack {
            List {
                Text("Select Language")
                    .font(.title)
                    .frame(alignment: .leading)
                SettingsRow(languageText: "English", selectedLanguage: $selectedLanguage)
                SettingsRow(languageText: "Hindi", selectedLanguage: $selectedLanguage)
                SettingsRow(languageText: "Telugu", selectedLanguage: $selectedLanguage)
                SettingsRow(languageText: "Sanskrit", selectedLanguage: $selectedLanguage)
            }
        }
        .navigationTitle("Settings")
    }
}

struct SettingsRow: View {
    var languageText: String
    @Binding var selectedLanguage: Language?
    @State private var isVisible = false
    @Environment(\.dismiss) var dismiss
    
    var tap: some Gesture {
        TapGesture()
            .onEnded { _ in
                self.selectedLanguage = Language(rawValue: languageText)
                isVisible.toggle()
                dismiss()
            }
    }
    
    var body: some View {
        HStack {
            Text(languageText)
                .tag(languageText)
            Spacer()
            if isVisible || selectedLanguage?.rawValue == languageText {
                Image(systemName: "checkmark")
            }
        }
        .gesture(tap)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(selectedLanguage: Binding(selectedLanguage))
    }
    
    private static var selectedLanguage: Binding<Language> {
        Binding(
            get: { Language.english },
            set: { _ in
                _ = Language.english
            }
        )
    }
}
