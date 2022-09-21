#if canImport(PDFKit) && os(iOS)
import PDFKit

extension PDFDocument {
    
    public func previewImage(_ box: CGPDFBox = .mediaBox) -> UIImage? {
        guard let document = documentRef else { return nil }
        guard let page = document.page(at: 1) else { return nil }
        let pageRect = page.getBoxRect(box)
        let renderer = UIGraphicsImageRenderer(size: pageRect.size)
        let image = renderer.image { context in
            UIColor.white.set()
            context.fill(pageRect)
            context.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
            context.cgContext.scaleBy(x: 1.0, y: -1.0)
            context.cgContext.drawPDFPage(page)
        }
        return image
    }
}
#endif
