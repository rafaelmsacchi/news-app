import Combine
import Foundation

struct FetchNewsRequest: Encodable {
    enum Category: String, Encodable {
        case business, entertainment, general, health, science, sports, technology
    }
    let country: String
    let category: Category?
    let sources: String?
    let q: String?
    let pageSize: Int?
    let page: Int?
    
    init(country: String = "br", page: Int? = nil, sources: String? = nil, category: Category? = nil, q: String? = nil, pageSize: Int? = nil) {
        self.country = country
        self.category = category
        self.sources = sources
        self.q = q
        self.pageSize = pageSize
        self.page = page
    }
    
    func toQueryItems() -> [URLQueryItem] {
        var queryItems = [
            URLQueryItem(name: "country", value: country)
        ]
        if let category = category?.rawValue {
            queryItems.append(URLQueryItem(name: "category", value: category))
        }
        if let sources {
            queryItems.append(URLQueryItem(name: "sources", value: sources))
        }
        if let q {
            queryItems.append(URLQueryItem(name: "q", value: q))
        }
        if let pageSize {
            queryItems.append(URLQueryItem(name: "pageSize", value: String(pageSize)))
        }
        if let page {
            queryItems.append(URLQueryItem(name: "page", value: String(page)))
        }
        return queryItems
    }
}

enum NetworkingError: Error {
    case urlFailedToBuild
    case parseError(_ associatedError: Error)
}

class Networking: NSObject {
    
    static let shared = Networking()
    
    private lazy var session: URLSession = {
        URLSession(configuration: .default, delegate: nil, delegateQueue: nil)
    }()

    private let baseURL = "https://newsapi.org"
    private let commonHeaders: [String: Any] = [
        "X-Api-Key": "4d3ff51b631448798b46e7d1061e2139"
    ]
    
    public func fetchNewsAA(_ newsRequest: FetchNewsRequest, extraHeaders: [String: Any] = [:]) async throws -> ArticlesResult {
        guard let url = URL(string: baseURL)?
            .appending(path: "/v2/top-headlines")
            .appending(queryItems: newsRequest.toQueryItems())
        else { throw NetworkingError.urlFailedToBuild }
        
        var request = URLRequest(url: url)
        commonHeaders.merging(extraHeaders, uniquingKeysWith: { f, s in f }).forEach { key, value in
            if let value = value as? String {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }

        let (data, _) = try await session.data(for: request)
        return try JSONDecoder().decode(ArticlesResult.self, from: data)
    }
    
    public func fetchNews(_ newsRequest: FetchNewsRequest, extraHeaders: [String: Any] = [:]) -> AnyPublisher<ArticlesResult, NetworkingError> {
        guard let url = URL(string: baseURL)?
            .appending(path: "/v2/top-headlines")
            .appending(queryItems: newsRequest.toQueryItems())
        else { return Fail(error: NetworkingError.urlFailedToBuild).eraseToAnyPublisher() }
        
        var request = URLRequest(url: url)
        commonHeaders.merging(extraHeaders, uniquingKeysWith: { f, s in f }).forEach { key, value in
            if let value = value as? String {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return session.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: ArticlesResult.self, decoder: JSONDecoder())
            .mapError { error in
                return NetworkingError.parseError(error)
            }
            .eraseToAnyPublisher()
    }
}
