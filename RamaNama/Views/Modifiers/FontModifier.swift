import SwiftUI

struct FontModifier: ViewModifier {
    var font: Font
    var color: Color

    func body(content: Content) -> some View {
            content
                .font(font)
                .foregroundColor(color)
                .multilineTextAlignment(.leading)
    }
}

enum TextType {
    case rowText
    case rowSubText
    case pageTitle
}

extension Font {
    static let rowText = Self.subheadline
    static let pageTitle = Self.headline
}

extension Color {
    static let rowText = Self.white
    static let rowSubText = Self.gray
    static let backgroundPrimary = Self.black
    static let titleText = Self.white
}

struct FontFactory {
    static func modifierFor(textType: TextType) -> FontModifier {
        var modifier: FontModifier

        switch textType {
        case .rowText:
            modifier = FontModifier(font: Font.rowText, color: Color.rowText)
        case .rowSubText:
            modifier = FontModifier(font: Font.rowText, color: Color.rowSubText)
        case .pageTitle:
            modifier = FontModifier(font: Font.headline, color: Color.rowText)
        }
        return modifier
    }
}
