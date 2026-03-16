import Foundation

protocol MainRouterDelegate: AnyObject {
}

final class MainRouter {
    weak var delegate: MainRouterDelegate?
}
