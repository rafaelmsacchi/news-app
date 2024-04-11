import Combine
import SwiftUI
import Foundation

@Observable class HomeViewModel {
    
    var localArticles: [LocalArticle] = []
    var countries: CountryList {
        didSet { fetchNewsAA() }
    }
    
    
    private let networking = Networking.shared
    private let newsRepository = NewsRepository()
    private var cancellables: [AnyCancellable] = []
    
    init() {
        self.countries = CountryFactory.makeCountryList()
        fetchNewsAA()
    }
    
    private func fetchNewsAA() {
        Task {
            do {
                let result = try await networking.fetchNewsAA(FetchNewsRequest(country: countries.selectedCountry.isoCode))
                localArticles = newsRepository.localArticles(from: result)
            } catch let error {
                print("error: ", error)
            }
        }
    }
    
    public func country(at index: Int) -> Country {
        countries.countries[index]
    }
    
    public func menuColor(at index: Int) -> Color {
        if index == countries.selectedIndex {
            Color(red: 0.5, green: 0.5, blue: 0.5)
        } else {
            Color(red: 0.25, green: 0.25, blue: 0.25)
        }
    }
    
    public func selectCountry(at index: Int) {
        guard index != countries.selectedIndex else { return }
        countries.selectedIndex = index
    }
    
    public func localArticle(from id: String) -> LocalArticle {
        localArticles.first(where: { $0.id == id })!
    }
    
    public func isFavourite(id: String) -> Bool {
        localArticles.first(where: { $0.id == id })?.favorite ?? false
    }
    
}

struct NameAvailableMessage: Codable {
    var isAvailable: Bool
    var name: String
}
enum NetworkError: Error {
    case invalidRequestError(String)
    case transportError(Error)
    case serverError(statusCode: Int)
    case noData
    case decodingError(Error)
    case encodingError(Error)
}

enum CellType: Hashable, Identifiable {
    var id: String {
        switch self {
        case let .header(data):
            data.id
        case let .text(data):
            data.id
        }
    }
    
    case header(HeaderCellData)
    case text(TextCellData)
}

class NewData: NSObject, Identifiable {
    var id: Int { hashValue }
    var cellTypeList: [CellType]
    
    init(cellTypeList: [CellType]) {
        self.cellTypeList = cellTypeList
    }
    
    func headerData() -> HeaderCellData? {
        cellTypeList.compactMap { type in
            if case let .header(headerCellData) = type {
                headerCellData
            } else {
                nil
            }
        }.first
    }
}

struct HeaderCellData: Hashable {
    let id: String
    let imageURL: URL
    let imageOverlayMessage: String?
    let title: String
    let timeText: String?
    
    var favorite: Bool
    var favoriteNote: String
}

struct TextCellData: Hashable {
    let id: String
    let text: String
}

let urlString1 = "data:image/jpeg;base64,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"

let urlString2 = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGacTOzUNTR19hk-GRG2VUVwjRUBDib3c0Vg&usqp=CAU"

let urlString3 = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTGmPRyZeiAUW3CtV0ydkq2Hq918eclxKQTQ&usqp=CAU"
