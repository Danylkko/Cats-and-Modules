//
//  CatFetcher.swift
//  Networking
//
//  Created by Danylo Litvinchuk on 19.06.2022.
//

import Foundation

public class CatFetcher: ObservableObject {
    
    @Published public var cats = [Cat]()
    
    private var limit: Int
    private var completionHandler: (() -> Void)?
    
    private var apiConfig: (String, String)? {
        let apiName = Bundle.main.object(forInfoDictionaryKey: "apiName") as! String
        switch apiName {
        case "CATS":
            return ("cat", "2e7c154e-d12a-417d-82df-d7a32daed167")
        case "DOGS":
            return ("dog", "6ed00c06-679d-4109-840f-417296a5d5db")
        default:
            return nil
        }
    }
    
    var totalPages = 0
    
    public init(limit: Int, completionHandler: (() -> Void)? = nil) {
        self.limit = limit
        self.completionHandler = completionHandler
        Task {
            await fetch()
        }
    }
    
    public func fetchMoreCats(cat: Cat) {
        if self.cats.last?.id == cat.id {
            Task {
                await self.fetch()
            }
        }
    }
    
    private func fetch() async {
        guard let apiConfig = apiConfig else { return }
        var urlComponents = URLComponents(string: "https://api.the\(apiConfig.0)api.com/v1/images/search")!
        urlComponents.queryItems = [URLQueryItem(name: "api_key", value: apiConfig.1),
                                    URLQueryItem(name: "limit", value: String(self.limit))]
        do {
            guard let url = urlComponents.url else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            let cats = try? JSONDecoder().decode([Cat].self, from: data)
            if let uwCats = cats {
                self.totalPages += 1
                DispatchQueue.main.async {
                    if let completionHandler = self.completionHandler, self.totalPages <= 1 {
                        completionHandler()
                    }
                    self.cats += uwCats
                }
            }
        } catch {
            print("Failed to fetch data")
        }
    }
}
