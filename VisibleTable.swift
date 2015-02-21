
import Foundation
import Cocoa

protocol VisibleTableDelegate {
    func resetAll()
}

class VisibleTable {
    
    
    var content: [[Cell]] = [[]]
    var rowsCount = 0
    var columnsCount = 0
    var previousRowsCount = 0
    var previousColumnsCount = 0
    var cellWidth:CGFloat = 50
    var cellHeight:CGFloat = 100
    var delegate: VisibleTableDelegate?
    
    
    init(rows: Int=1, columns: Int=1, cellWidth: CGFloat = 50, cellHeight: CGFloat = 100) {
        
        self.cellWidth = cellWidth
        self.cellHeight = cellHeight
        
/// MARK: Init Content
        
        content = [[]]
        printCurrentState()
        for var c = 0; c < columns; c++ {
            var tmpColumn: [Cell] = []
            printCurrentState()
            for var r = 0; r < rows; r++ {
                var cellFrame = NSRect(x:((cellWidth * CGFloat(c))), y: ((cellHeight * CGFloat(r))), width: cellWidth, height: cellHeight)
                var tmpCell = Cell(frame: cellFrame)
//                tmpColumn.insert(tmpCell, atIndex: r)
                tmpColumn.append(tmpCell)
                
            }
            content.insert(tmpColumn, atIndex: c)
            
        }
        
        rowsCount = rows
        columnsCount = columns
        previousColumnsCount = columns
        previousRowsCount = rows
        printCurrentState()
        
        
    }
    
/// Draw Table on View ///
    
    func drawTableOnView(view: NSView) {
        for var c = previousColumnsCount-1; c < columnsCount; c++ {
            for var r = previousRowsCount-1; r < rowsCount; r++ {
                
                content[c][r].frame.origin.x = content[c][r].frame.origin.x
                
                view.addSubview(content[c][r])
//                let path = NSBezierPath()
//                path.moveToPoint(CGPoint(x: content[c][r].frame.origin.x, y: content[c][r].frame.origin.y))
//                path.lineToPoint(NSPoint(x: content[c][r].frame.origin.x, y: content[c][r].frame.origin.y+cellHeight))
//                let anim = CAKeyframeAnimation(keyPath: "position")
//                anim.repeatCount = 1
//                anim.duration = 0.2
//                anim.path = path.CGPath
//                content[c][r].layer!.addAnimation(anim, forKey: "animate position along path")
            }
        }
        previousColumnsCount = columnsCount
        previousRowsCount = rowsCount
    
    
////        var i = 0
////        for i = 0 ; i < 5; ++i {
////        
//        // create a square
//        let square = NSView()
//        square.frame = CGRect(x: 55, y: 300, width: 20, height: 20)
//        square.wantsLayer = true
//        square.layer!.backgroundColor = NSColor.redColor().CGColor
//        view.addSubview(square)
//        
//        // randomly create a value between 0.0 and 150.0
//        let randomYOffset = CGFloat( arc4random_uniform(150))
//        
//        // for every y-value on the bezier curve
//        // add our random y offset so that each individual animation
//        // will appear at a different y-position
//        let path = NSBezierPath()
////        path.moveToPoint(CGPoint(x: 16,y: 239 + randomYOffset))
////        
////        path.curveToPoint(CGPoint(x: 301, y: 239 + randomYOffset), controlPoint1: CGPoint(x: 136, y: 373 + randomYOffset), controlPoint2: CGPoint(x: 178, y: 110 + randomYOffset))
////        
//
//            path.moveToPoint(CGPoint(x: 26, y: 239))
//            path.lineToPoint(NSPoint(x: 26, y: 340))
//            // create the animation
//        let anim = CAKeyframeAnimation(keyPath: "position")
//        
//        anim.path = path.CGPath
//        anim.rotationMode = kCAAnimationRotateAuto
//        anim.repeatCount = Float.infinity
//        anim.duration = 5.0
//        
//        // add the animation
//        square.layer!.addAnimation(anim, forKey: "animate position along path")
////        }
    }
    
    
/// AddColumn ///
    
    func addColumn(){
        var tmpColumn: [Cell] = []
        /// FIXME: Content has to many colums
        
        var upperRightCellFrame: NSRect = content[content.count-2][0].frame
        for var r = 0; r < rowsCount; r++ {
            var cellFrame = NSRect(x:upperRightCellFrame.origin.x + upperRightCellFrame.width , y: upperRightCellFrame.origin.y + (cellHeight * CGFloat(r)), width: cellWidth, height: cellHeight)
            var tmpCell = Cell(frame: cellFrame)
            
            tmpColumn.insert(tmpCell, atIndex: r)
//            tmpColumn.append(tmpCell)
        }
        /// FIXME: -1
        content.insert(tmpColumn, atIndex: content.count-1)
//        content.append(tmpColumn)
        
        columnsCount++
       
        
    }

    
    
/// Mark: AddRow
    
    func addRow(){
        
        var bottomLeftCellFrame: NSRect = content[0][rowsCount-1].frame
        for var c = 0; c < columnsCount; c++ {
            var cellFrame = NSRect(x: bottomLeftCellFrame.origin.x + (CGFloat(c) * cellWidth), y: bottomLeftCellFrame.origin.y + bottomLeftCellFrame.height, width: bottomLeftCellFrame.width, height: bottomLeftCellFrame.height)
            
            var tmpCell = Cell(frame: cellFrame)
            
            content[c].append(tmpCell)
        }
        rowsCount++
        
        
    }

  
    
/// Mark: RemoveTableSubview from view
    
    func removeTableFromView(view: NSView) {
        

            view.subviews.removeAll(keepCapacity: true)
            self.content.removeAll(keepCapacity: false)
            delegate?.resetAll()
      
        
    }
    
    func updateArray(newNumberOfColumns: Int, newNumberOfRows: Int){
        
/// MARK: Increase size of table(add column and rows)
        
        previousRowsCount = rowsCount
        previousColumnsCount = columnsCount
        
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
            for c in 0...newNumberOfColumns {
                tempContent.append(Array(count: newNumberOfRows, repeatedValue: Cell(frame: NSRect())))
            }
            for var c = 0; c < newNumberOfColumns; c++ {
                                    println("CCCCCCC \(c)")
                for var r = 0; r < newNumberOfRows; r++ {

                    tempContent[c].insert(content[c][r], atIndex: r)
                    println("RRRRRRRR \(r)")
                }
            }
            content.removeAll()
            content = [[]]
            content = tempContent
            println("\n---------------\n ")
            println("TEMP COUNT _ \(tempContent.count)")
            var i=1;
            for col in tempContent {
                println("KolumnaTEMP \(i) - liczba wiersz \(col.count)")
                ++i
            }
            columnsCount = newNumberOfColumns
            rowsCount = newNumberOfRows
        }

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