import SwiftUI

enum Language: String {
    case english = "English"
    case hindi = "Hindi"
    case sanskrit = "Sanskrit"
    case telugu = "Telugu"
}

enum Book: String {
    case balaKanda = "Bala Kanda"
    case ayodhyaKanda = "Ayodhya Kanda"
    case aranyaKanda = "Aranya Kanda"
    case kishkindhaKanda = "Kishkindha Kanda"
    case sundaraKanda = "Sundara Kanda"
    case yuddhaKanda = "Yuddha Kanda"
    case uttaraKanda = "Uttara Kanda"
}

struct SettingsView: View {
    @Binding var selectedLanguage: Language
    @Binding var selectedBook: Book
    
    var body: some View {
        VStack {
            List {
                Group {
                    Text("Language")
                        .font(.title)
                        .frame(alignment: .leading)
                    SettingsLanguageRow(languageText: "English", selectedLanguage: $selectedLanguage)
                    SettingsLanguageRow(languageText: "Hindi", selectedLanguage: $selectedLanguage)
                    SettingsLanguageRow(languageText: "Telugu", selectedLanguage: $selectedLanguage)
                    SettingsLanguageRow(languageText: "Sanskrit", selectedLanguage: $selectedLanguage)
                }
                Group {
                    Text("Book")
                        .font(.title)
                        .frame(alignment: .leading)
                    SettingsBookRow(bookName: "Bala Kanda", selectedBook: $selectedBook)
                    SettingsBookRow(bookName: "Ayodhya Kanda", selectedBook: $selectedBook)
                    SettingsBookRow(bookName: "Aranya Kanda", selectedBook: $selectedBook)
                    SettingsBookRow(bookName: "Kishkindha Kanda", selectedBook: $selectedBook)
                    SettingsBookRow(bookName: "Sundara Kanda", selectedBook: $selectedBook)
                    SettingsBookRow(bookName: "Yuudha Kanda", selectedBook: $selectedBook)
                    SettingsBookRow(bookName: "Uttara Kanda", selectedBook: $selectedBook)
                }
            }
        }
        .foregroundColor(.orange)
        .navigationTitle("Settings")
    }
}

struct SettingsLanguageRow: View {
    var languageText: String
    @Binding var selectedLanguage: Language
    @State private var isVisible = false
    @Environment(\.dismiss) var dismiss
        
    var body: some View {
        HStack {
            Text(languageText)
                .tag(languageText)
            Spacer()
            if isVisible || selectedLanguage.rawValue == languageText {
                Image(systemName: "checkmark")
            }
        }
        .onTapGesture {
            self.selectedLanguage = Language(rawValue: languageText) ?? .english
            isVisible.toggle()
            dismiss()
        }
    }
}

struct SettingsBookRow: View {
    var bookName: String
    @Binding var selectedBook: Book
    @State private var isVisible = false
    @Environment(\.dismiss) var dismiss
    
    var tap: some Gesture {
        TapGesture()
            .onEnded { _ in
                self.selectedBook = Book(rawValue: bookName) ?? .balaKanda
                isVisible.toggle()
                dismiss()
            }
    }
    
    var body: some View {
        HStack {
            Text(bookName)
                .tag(bookName)
            Spacer()
            if isVisible || selectedBook.rawValue == bookName {
                Image(systemName: "checkmark")
            }
        }
        .onTapGesture {
            self.selectedBook = Book(rawValue: bookName) ?? .balaKanda
            isVisible.toggle()
            dismiss()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(selectedLanguage: Binding(projectedValue: selectedLanguage), selectedBook: selectedBook)
    }
    
    private static var selectedLanguage: Binding<Language> {
        Binding(
            get: { Language.english },
            set: { _ in
                _ = Language.english
            }
        )
    }
    
    private static var selectedBook: Binding<Book> {
        Binding(
            get: { Book.balaKanda },
            set: { _ in
                _ = Book.balaKanda
            }
        )
    }
}
