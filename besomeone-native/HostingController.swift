
import SwiftUI

class HostingController: UIHostingController<ContentView> {
      // 1. We change this variable
    private var currentStatusBarStyle: UIStatusBarStyle = .default
      // 2. To change this property of `UIHostingController`
    override var preferredStatusBarStyle: UIStatusBarStyle {
        currentStatusBarStyle
    }
      // 3. A function we can call to change the style programmatically
    func changeStatusBarStyle(_ style: UIStatusBarStyle) {
        self.currentStatusBarStyle = style
          // 4. Required for view to update
        self.setNeedsStatusBarAppearanceUpdate()
    }
}

