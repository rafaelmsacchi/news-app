//
//  TestTests.swift
//  TestTests
//
//  Created by Rafael Sacchi on 16/02/2024.
//

import XCTest
@testable import Test

extension ArticlesResult {
    
    static func mock() -> ArticlesResult {
        let articles = [
            Article(
                source: Article.Source(id: "1", name: "G1"),
                author: "William Bonner",
                title: "Noticia importante",
                description: "Esta é muito importante",
                url: "https://google.com",
                urlToImage: nil,
                publishedAt: nil,
                content: nil
            ),
            Article(
                source: Article.Source(id: "2", name: "G1"),
                author: "William Bonner",
                title: "[Removed]",
                description: "Esta é menos importante",
                url: "https://google.com",
                urlToImage: nil,
                publishedAt: nil,
                content: nil
            )
        ]
        return ArticlesResult(status: "ok", totalResults: 2, articles: articles)
    }
    
}

final class TestTests: XCTestCase {
    
    let newsRepository = NewsRepository()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFiltersRemoved() throws {
        let articles = newsRepository.localArticles(from: ArticlesResult.mock())
        XCTAssertEqual(articles.count, 1)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
