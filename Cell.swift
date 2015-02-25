import Cocoa
import QuartzCore

class Cell: NSView {

    var txtField: NSTextField!
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        
    }
    
    override init(frame: NSRect){
        super.init(frame: frame)
        
        var bgColor = NSColor(calibratedRed: 170/250, green: 193/250, blue: 210/250, alpha: 1)
    
        
        txtField = NSTextField(frame: NSRect(x: 0, y: 0, width: frame.width, height: frame.height))
        txtField.wantsLayer = true
        txtField.backgroundColor = NSColor(calibratedRed: 170/250, green: 193/250, blue: 210/250, alpha: 1)
        txtField.layer?.borderColor = NSColor.whiteColor().CGColor
        txtField.font = NSFont(name: "San Francisco Display" , size: 12)
        txtField.alignment = NSTextAlignment.CenterTextAlignment
        
        self.addSubview(txtField)
        self.wantsLayer = true
        self.layer?.borderColor = NSColor.whiteColor().CGColor
        self.layer?.borderWidth = 1.0

        
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
