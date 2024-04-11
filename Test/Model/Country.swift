import Foundation

struct Country: Equatable {
    let isoCode: String
    let name: String
    let flag: String
}

struct CountryList: Equatable {
    let countries: [Country]
    var selectedIndex: Int
    
    private let defaultCountry = Country(isoCode: "us", name: "USA", flag: "🇺🇸")
    
    var selectedCountry: Country {
        if selectedIndex > 0 && selectedIndex < countries.count {
            countries[selectedIndex]
        } else {
            defaultCountry
        }
    }

}

struct CountryFactory {
    
    static func makeCountryList() -> CountryList {
        CountryList(countries:
                        [
                            Country(isoCode: "us", name: "USA", flag: "🇺🇸"),
                            Country(isoCode: "br", name: "Brazil", flag: "🇧🇷"),
                            Country(isoCode: "gb", name: "United Kingdom", flag: "🇬🇧"),
                            Country(isoCode: "ru", name: "Russia", flag: "🇷🇺"),
                            Country(isoCode: "in", name: "India", flag: "🇮🇳"),
                            Country(isoCode: "jp", name: "Japan", flag: "🇯🇵")
                        ],
                    selectedIndex: 0)
    }
    
}
