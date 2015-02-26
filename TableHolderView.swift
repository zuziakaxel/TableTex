
import Foundation
import Cocoa

class TableHolderView: NSView {
    
    override var flipped:Bool {
        get {
            return true
        }
    }
    override func mouseDown(theEvent: NSEvent) {
        self.superview?.mouseDown(theEvent)
    }
    
}