import Foundation

public protocol Router {
    var hostname: String { get }
    var url: URL? { get }
}
