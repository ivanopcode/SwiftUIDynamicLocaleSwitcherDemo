// Copyright (c) 2025 Ivan Oparin
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import SwiftUI

class LanguageManager: ObservableObject {
    /// The currently selected locale, published to notify subscribers of changes.
    @Published var currentLanguage: Locale {
        didSet {
            UserDefaults.standard.set(currentLanguage.identifier, forKey: "selectedLanguage")
            localeDidChange.toggle()
        }
    }
    
    /// The layout direction for the currently selected locale.
    /// This property is not marked as @Published because changes to currentLanguage already trigger the necessary object change events.
    var layoutDirection: LayoutDirection {
        let languageCode = currentLanguage.language.languageCode?.identifier ?? "en"
        let direction = NSLocale.characterDirection(forLanguage: languageCode)
        return direction == .rightToLeft ? .rightToLeft : .leftToRight
    }
    
    @Published private(set) var localeDidChange: Bool = false

    init() {
        if let savedLanguage = UserDefaults.standard.string(forKey: "selectedLanguage"),
           let locale = Locale(identifier: savedLanguage) as Locale? {
            self.currentLanguage = locale
        } else {
            self.currentLanguage = Locale(identifier: "en")
        }
    }
}
