
import Foundation
import Cocoa

protocol VisibleTableDelegate {
    func resetAll()
}

class VisibleTable {

    var content: [[Cell]] = [[]]
    var rowsCount = 0
    var columnsCount = 0
    var cellWidth:CGFloat = 50
    var cellHeight:CGFloat = 100
    var delegate: VisibleTableDelegate?
    var superVC: TableHolderView!
 
    init(tableHolderView: TableHolderView, rows: Int = 1, columns: Int = 1, cellWidth: CGFloat = 50, cellHeight: CGFloat = 100) {
        
        self.cellWidth = cellWidth
        self.cellHeight = cellHeight
        self.superVC = tableHolderView
        content = [[]]
        printCurrentState()
        for var c = 0; c < columns; ++c {
            var tmpColumn: [Cell] = []
            printCurrentState()
            for var r = 0; r < rows; r++ {
                var cellFrame = NSRect(x:((cellWidth * CGFloat(c))), y: ((cellHeight * CGFloat(r))), width: cellWidth, height: cellHeight)
                var tmpCell = Cell(frame: cellFrame)
                tmpColumn.insert(tmpCell, atIndex: r)
            }
            content.insert(tmpColumn, atIndex: c)
        }
        rowsCount = rows
        columnsCount = columns
        printCurrentState()
        self.drawTableOnView(superVC)
    }
    
    func drawTableOnView(view: NSView) {
        for var c = 0; c < columnsCount; ++c {
            for var r = 0; r < rowsCount; r++ {
                view.addSubview(content[c][r])
            }
        }
    }

    func addColumn(){
        var tmpColumn: [Cell] = []
        var upperRightCellFrame: NSRect = content[columnsCount-1][0].frame
        for var r = 0; r < rowsCount; r++ {
            var cellFrame = NSRect(x:upperRightCellFrame.origin.x + upperRightCellFrame.width , y: upperRightCellFrame.origin.y + (cellHeight * CGFloat(r)), width: cellWidth, height: cellHeight)
            var tmpCell = Cell(frame: cellFrame)
            tmpColumn.insert(tmpCell, atIndex: r)
        }
        content.insert(tmpColumn, atIndex: columnsCount)
        columnsCount++
    }
    
    func addRow(){
        
        var bottomLeftCellFrame: NSRect = content[0][rowsCount-1].frame
        for var c = 0; c < columnsCount; ++c {
            var cellFrame = NSRect(x: bottomLeftCellFrame.origin.x + (CGFloat(c) * cellWidth), y: bottomLeftCellFrame.origin.y + bottomLeftCellFrame.height, width: bottomLeftCellFrame.width, height: bottomLeftCellFrame.height)
            
            var tmpCell = Cell(frame: cellFrame)
            content[c].append(tmpCell)
        }
        rowsCount++
    }
    
    func updateArray(newNumberOfColumns: Int, newNumberOfRows: Int){
        
/// MARK: Increase size of table(add column and rows)
        
        if newNumberOfColumns < 1 || newNumberOfRows < 1 {
            return
        }
        if newNumberOfColumns > columnsCount || newNumberOfRows > rowsCount {
            for var i = 0; i < (newNumberOfColumns - columnsCount); i++ {
                addColumn()
            }
            for var i = 0; i < (newNumberOfRows-rowsCount); i++ {
                addRow()
            }
        }
        
/// MARK: Shrink table
        
        else {
            var tempContent: [[Cell]] = [[]]

            for var col = 0; col < newNumberOfColumns; ++col {
                var tmpColumn: [Cell] = []
                    for var r = 0; r < newNumberOfRows; ++r {
                        tmpColumn.insert(content[col][r], atIndex: r)
                }
                tempContent.insert(tmpColumn, atIndex: col)

            }
            columnsCount = newNumberOfColumns
            rowsCount = newNumberOfRows
            content.removeAll()
            content.removeAll(keepCapacity: false)
            content = [[]]
            printCurrentState()
            content = tempContent
            printCurrentState()
            superVC.subviews.removeAll(keepCapacity: false)
            
            
        }
        self.drawTableOnView(superVC)
        printCurrentState()
    }
    
    func printCurrentState(){
     
        println("\n---------------\n liczba kolumn - \(content.count)")
        var i=1;
        for col in content {
            println("Kolumna \(i) - liczba wiersz \(col.count)")
            ++i
        }
        println("rows - \(rowsCount)")
        println("columns - \(columnsCount)")
        println("--------------------")
    }
    
    
    
}