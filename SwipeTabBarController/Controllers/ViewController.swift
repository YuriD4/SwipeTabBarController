import UIKit

class BaseScrollDelegateViewController: UIViewController, P_TabBarChildViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - P_TabBarChildViewController
    weak var scrollDelegate: P_TabBarChildViewControllerDelegate!
    func updateScrollContentOffsetIfNeeded(to y: CGFloat, animated: Bool) {
        let contentOffset = CGPoint(x: 0, y: y)
        tableView?.setContentOffset(contentOffset, animated: animated)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = indexPath.description
        return cell
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.tabBarChildViewController(self, scrollViewDidScroll: scrollView)
    }
    
}

final class ViewController0: BaseScrollDelegateViewController {


}

final class ViewController1: BaseScrollDelegateViewController {

    

}

final class ViewController2: UIViewController {

    private(set) lazy var keyboardDismissGestureRecognizer: UIGestureRecognizer = UITapGestureRecognizer()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        beginKeyboardObserving()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        endKeyboardObserving()
    }
}

extension ViewController2: P_KeyboardObservableWithDismiss {
    
    var keyboardObserveOptions: KeyboardObservableOptions { .showHide }
    
}
