//
//  PDFCreator.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 30/04/2024.
//

import Foundation
import SwiftUI
import PDFKit
class PDFCreator: ObservableObject {
    @Published var documentData: Data?
    @Published var showShareSheet = false
    @Published var isLoading = false

    func createAndSavePDF(with data: [Oder]) {
        guard !data.isEmpty else {
            print("No data to export")
            return
        }

        DispatchQueue.global().async {
            // Tạo PDF từ dữ liệu
            let pdfMetaData = [
                kCGPDFContextCreator: "AppOrderFood",
                kCGPDFContextAuthor: "author name"
            ]
            let format = UIGraphicsPDFRendererFormat()
            format.documentInfo = pdfMetaData as [String: Any]

            let pageSize = CGSize(width: 595, height: 842)
            let renderer = UIGraphicsPDFRenderer(bounds: CGRect(origin: .zero, size: pageSize), format: format)

            let data = renderer.pdfData { context in
                for order in data {
                    context.beginPage()

                    let orderInfo = "Order ID: \(order.hashValue)\nCustomer: \(order.name)\nTotal: \(order.total)\nAdress: \(order.adress)"
                    orderInfo.draw(in: CGRect(x: 20, y: 20, width: pageSize.width - 40, height: pageSize.height - 40), withAttributes: nil)
                }
            }

            // Lưu PDF vào local
            guard let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
            let pdfPath = documentsPath.appendingPathComponent("output.pdf")
            try? data.write(to: pdfPath)

            DispatchQueue.main.async {
                self.documentData = data
                self.showShareSheet = true
            }
        }
    }
}
