import Foundation
import Combine

public class SearchBarViewModel: ObservableObject {
    @Published  var text: String = ""
    
    private let searchSubject = PassthroughSubject<String, Never>()

    public var searchPublisher: AnyPublisher<String, Never> {
        searchSubject.eraseToAnyPublisher()
    }

    enum Action {
        case onSubmit
        case clear
    }

    public init() {
    }

    func trigger(_ action: Action) {
        switch action {
        case .onSubmit:
            searchSubject.send(text)
        case .clear:
            text = ""
        }
    }
}
