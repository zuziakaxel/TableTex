//
//  TableTextField.swift
//  TableTex
//
//  Created by Axel Zuziak on 26.02.2015.
//  Copyright (c) 2015 Axel Zuziak. All rights reserved.
//
import Foundation
import Cocoa

class TableTextField: NSTextField {

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        
    }
    
    override func mouseDown(theEvent: NSEvent) {
        println("Cell")
        var keepOn = true
        var isInside = true
        var mouseLocation: NSPoint = theEvent.locationInWindow
        
        self.superview?.mouseDown(theEvent)
    }
    
}
