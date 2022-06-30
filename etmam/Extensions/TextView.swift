//
//  TextView.swift
//  calenderSwift
//
//  Created by Danya T on 15/11/1443 AH.
//

import SwiftUI



struct TextView: UIViewRepresentable {
    typealias UIViewType = UITextView
    
    var placeholderText: String
    @Binding var text: String
    var minHeight: CGFloat
    var maxHeight : CGFloat
    @Binding var calculatedHeight: CGFloat
    init(placeholderText: String, text: Binding<String>, minHeight: CGFloat,maxHeight: CGFloat ,calculatedHeight: Binding<CGFloat>) {
        self.placeholderText = placeholderText
        self._text = text
        self.minHeight = minHeight
        self.maxHeight = maxHeight
        self._calculatedHeight = calculatedHeight
    }

   

    func makeUIView(context: UIViewRepresentableContext<TextView>) -> UITextView {
        let textView = LineSpacingTextView()
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero

        // Decrease priority of content resistance, so content would not push external layout set in SwiftUI
        textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.isScrollEnabled = true
     
        textView.isUserInteractionEnabled = true
   

        // Set the placeholder
        textView.text = placeholderText
        textView.textColor = .placeholderText
        textView.backgroundColor = .clear

        return textView
    }

    func updateUIView(_ textView: UITextView, context: UIViewRepresentableContext<TextView>) {
        if text != "" || textView.textColor == .label {
            textView.text = text
            textView.textColor = .label
        }
       
      
        textView.delegate = context.coordinator
       
        recalculateHeight(view: textView)
       
    }

    func recalculateHeight(view: UIView) {
        let newSize = view.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        if newSize.height > maxHeight {
            self.$calculatedHeight.wrappedValue = self.maxHeight
            
        }
        else if minHeight < newSize.height && $calculatedHeight.wrappedValue != newSize.height {
            DispatchQueue.main.async {
                self.$calculatedHeight.wrappedValue = newSize.height // !! must be called asynchronously
            }
        } else if minHeight >= newSize.height && $calculatedHeight.wrappedValue != minHeight {
            DispatchQueue.main.async {
                self.$calculatedHeight.wrappedValue = self.minHeight // !! must be called asynchronously
            }
        }

    }
    func makeCoordinator() -> TextView.Coordinator {
        Coordinator(self)
    }
    class Coordinator : NSObject, UITextViewDelegate {

        var parent: TextView

        init(_ uiTextView: TextView) {
            self.parent = uiTextView
        }

        func textViewDidChange(_ textView: UITextView) {
            // This is needed for multistage text input (eg. Chinese, Japanese)
            
            
                parent.recalculateHeight(view: textView)
            
               parent.text = textView.text
        }

        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == .placeholderText{
                textView.text = ""
                textView.textColor = .label
            }
        }

        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text == "" {
                textView.text = parent.placeholderText
                textView.textColor = .placeholderText
            }
        }
    }
}


class LineSpacingTextView: UITextView, NSLayoutManagerDelegate {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        layoutManager.delegate = self
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - NSLayoutManagerDelegate

    func layoutManager(_ layoutManager: NSLayoutManager, lineSpacingAfterGlyphAt glyphIndex: Int, withProposedLineFragmentRect rect: CGRect) -> CGFloat {
        return 4
    }

}
