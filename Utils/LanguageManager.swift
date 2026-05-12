import SwiftUI
class LanguageManager: ObservableObject {
    @Published var currentLanguage: String {
        didSet {
            UserDefaults.standard.set(currentLanguage, forKey: "appLanguage")
            Bundle.setLanguage(currentLanguage)
        }
    }
    static let shared = LanguageManager()
    let availableLanguages = [
        ("en", "english"),
        ("ru", "русский"),
        ("es", "español"),
        ("fr", "français"),
        ("de", "deutsch"),
        ("it", "italiano")
    ]
    init() {
        if let saved = UserDefaults.standard.string(forKey: "appLanguage") {
            currentLanguage = saved
        } else {
            let systemLang = Locale.current.language.languageCode?.identifier ?? "en"
            let supported = ["en", "ru", "es", "fr", "de", "it"]
            currentLanguage = supported.contains(systemLang) ? systemLang : "en"
        }
        Bundle.setLanguage(currentLanguage)
    }
}
private var bundleKey: UInt8 = 0
class BundleExtension: Bundle, @unchecked Sendable {
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        guard let bundle = objc_getAssociatedObject(self, &bundleKey) as? Bundle else {
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
        return bundle.localizedString(forKey: key, value: value, table: tableName)
    }
}
extension Bundle {
    static func setLanguage(_ language: String) {
        defer {
            object_setClass(Bundle.main, BundleExtension.self)
        }
        guard let path = Bundle.main.path(forResource: language, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return
        }
        objc_setAssociatedObject(Bundle.main, &bundleKey, bundle, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
