import Foundation

class HomeService {
    
    var serviceManager: ServiceManager
    
    init(serviceManager: ServiceManager = ServiceManager()) {
        self.serviceManager = serviceManager
    }
    
    public func fetchPokemonList(completion: @escaping(Result<[Pokemon], NetworkError>) -> Void) {
        let group = DispatchGroup()
        let url: String = "https://pokeapi.co/api/v2/pokemon?limit=107&offset=386"
        var urls: [String] = []
        var pokemonList: [Pokemon] = []
        
        serviceManager.request(with: url, method: .get, DecodeType: PokemonListResponse.self) { result in
            switch result {
            case .success(let success):
                urls = success.results.map { $0.url}
                
                for url in urls {
                    group.enter()
                    
                    self.serviceManager.request(with: url, method: .get, DecodeType: Pokemon.self) { result in
                        switch result {
                        case .success(let pokemon):
                            pokemonList.append(pokemon)
                        case .failure(let failure):
                            print(failure)
                        }
                        
                        group.leave()
                    }
                }
                
                group.notify(queue: .main) {
                    completion(.success(pokemonList))
                }
                
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
