import Cocoa
import AppKit

class ViewController: NSViewController, VisibleTableDelegate {
 
    /// MARK: Steppers
    @IBOutlet weak var stepperColumns: NSStepper!
    @IBOutlet weak var txtColumns: NSTextField!
    @IBOutlet weak var stepperRows: NSStepper!
    @IBOutlet weak var txtRows: NSTextField!
    
    @IBAction func rowsDidChangeValue(sender: AnyObject) {
        if sender.integerValue == nbOfRows{
            return
        }
        updateRowsNumber(sender.integerValue)
    }
    @IBAction func columnsDidChangeValue(sender: AnyObject) {
        if sender.integerValue == nbOfColumns {
            return
        }
        updateColumnsNumber(sender.integerValue)
    }

    @IBOutlet var txtLaTeX: NSTextView!
    @IBOutlet weak var contentView: TableHolderView!
    @IBOutlet weak var cnsContentViewWidth: NSLayoutConstraint!
    @IBOutlet weak var cnsContentViewHeight: NSLayoutConstraint!
    
    var table: VisibleTable!
    var nbOfColumns = 1
    var nbOfRows = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.needsDisplay = true
        contentView.wantsLayer = true
        contentView.layer?.backgroundColor = NSColor(calibratedRed: 121/250, green: 187/250, blue: 248/250, alpha: 1).CGColor
        contentView.layer?.borderWidth = 4.0
        contentView.layer?.borderColor = NSColor.blackColor().CGColor
        
        contentView.drawRect(NSRect(x: contentView.frame.origin.x, y: contentView.frame.origin.x, width: contentView.frame.width, height: contentView.frame.height))
        contentView.needsDisplay = true
        
/// Create shadow
        
        var dropShadow = NSShadow()
        dropShadow.shadowColor = NSColor(calibratedRed: 121/250, green: 187/250, blue: 248/250, alpha: 1)
        dropShadow.shadowOffset = NSMakeSize(5, 10.0)
        dropShadow.shadowBlurRadius = 10.0
        contentView.shadow = dropShadow
        
        
        
        
        
        contentView.needsDisplay = true
        table = VisibleTable(rows: nbOfRows, columns: nbOfColumns, cellWidth: 70, cellHeight: 40)
        updateContentView()
        table.drawTableOnView(self.contentView)
        
        contentView.needsDisplay = true
        println(contentView.frame)

    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    



    @IBAction func generateButtonPressed(sender: AnyObject) {
        
        table.removeTableFromView(contentView)
        
    }
    
    func updateColumnsNumber(value: Int) {
        if value < 1 {
            
            return
        }
        stepperColumns.integerValue = value
        txtColumns.integerValue = value
        nbOfColumns = value
        table.updateArray(nbOfColumns, newNumberOfRows: nbOfRows)
        updateContentView()
    }
    
    func updateRowsNumber(value: Int) {
        if value < 1 {
            return
        }
        stepperRows.integerValue = value
        txtRows.integerValue = value
        nbOfRows = value
        table.updateArray(nbOfColumns, newNumberOfRows: nbOfRows)
        updateContentView()
    }
    
    func updateContentView(){
        
        cnsContentViewHeight.constant = table.cellHeight * CGFloat(table.rowsCount)
        cnsContentViewWidth.constant = table.cellWidth * CGFloat(table.columnsCount)
        table.drawTableOnView(contentView)
        
    }
    func resetAll(){
        viewDidLoad()
        nbOfColumns = 1
        nbOfRows = 1
        updateContentView()
    }
}




    

