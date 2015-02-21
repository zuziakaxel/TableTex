//
//
//
//
//
//import Foundation
//
//
//class LaTeXHandler {
//    
//    
//    var header: String!
//    
//    var text: [String] = []
//    
//    var footer: String = "\\end{tabular}\n\\end{table}\n"
//    
//    var strColumns: String = ""
//    
//    
//    
//    
//    init(rows: Int, columns: Int, tabelka: Tabela){
//        
//        for i in 1...columns {
//            strColumns = strColumns + "|C"
//        }
//        strColumns += "|"
//        
//        header = "\\begin{table}\n\\begin{tabular}[\(strColumns)]"
//        
//        
//        var txtCell = ""
//        for index in 0...rows-1 {
//            for l in 1...columns-1 {
//                
//                txtCell += "\(tabelka.arr[l][index].stringValue) & "
//                
//            }
//            text.append(txtCell)
//            text[index] += "\\\\ \\hline"
//            txtCell = ""
//        }
//    }
//    
//    
//    
//    func generate() -> String {
//        
//        var finalText: String = ""
//        
//        finalText += header
//        finalText += "\n"
//        
//        for index in text {
//            
//            finalText += index
//            finalText += "\n"
//            
//        }
//        finalText += footer
//        return finalText
//    }
//    
//    
//    
//    
//}