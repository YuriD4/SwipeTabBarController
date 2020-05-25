import UIKit

protocol P_TabBarChildViewControllerDelegate: class {
    func tabBarChildViewController(
        _ tabBarChildViewController: P_TabBarChildViewController,
        scrollViewDidScroll scrollView: UIScrollView)
    
}
protocol P_TabBarChildViewController: UIViewController, UIScrollViewDelegate {
    var scrollDelegate: P_TabBarChildViewControllerDelegate! { get set }
    var additionalTopContentInset: CGFloat { get set }
    var contentOffsetY: CGFloat { get }
    func updateScrollContentOffsetIfNeeded(to y: CGFloat, animated: Bool)
}
extension P_TabBarChildViewController {
    
    func prepare(additionalTopContentInset: CGFloat, contentOffsetY: CGFloat) {
        self.loadViewIfNeeded()
        self.additionalTopContentInset = additionalTopContentInset
    }
    
    func inserSharedView(_ sharedView: UIView) {
        view.addSubview(sharedView)
        sharedView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        sharedView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        sharedView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
}

extension UIViewController {
    
    var tabBarChildViewController: P_TabBarChildViewController? {
        if let vc = self as? P_TabBarChildViewController {
            return vc
        } else if let vc = self as? UINavigationController {
            return vc.viewControllers.compactMap { $0.tabBarChildViewController }.first
        } else {
            return nil
        }
    }
    
}
//protocol P_TabBarChildContainer {
//    var tabBarChildViewController: P_TabBarChildViewController? { get }
//}
//extension P_TabBarChildContainer where Self: UIViewController {
//    var tabBarChildViewController: P_TabBarChildViewController? {
//        self as? P_TabBarChildViewController
//    }
//}
//extension P_TabBarChildContainer where Self: UINavigationController {
//    var tabBarChildViewController: P_TabBarChildViewController? {
//        viewControllers.first(where: { $0.tabBarChildViewController != nil }) as? P_TabBarChildViewController
//    }
//}
//extension UIViewController: P_TabBarChildContainer { }