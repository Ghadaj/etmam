//
//  SwipeableView.swift
//  etmam
//
//  Created by Sara AlMezeini on 05/12/1443 AH.
//

import Foundation
import Combine
import SwiftUI

public class SwManager: ObservableObject {
    private var views: [SWViewModel]
    private var subscriptions = Set<AnyCancellable>()
    
    public init() {
        views = []
    }
    
    public func hideAllViews() {
        self.views.forEach {
            $0.goToCenter()
        }
    }
    
    public func addView(_ view: SWViewModel) {
        views.append(view)
        view.stateDidChange.sink(receiveValue: { vm in
            if self.views.count != 0 {
                self.views.forEach {
                    if vm.id != $0.id && $0.state != .center{
                        $0.goToCenter()
                    }
                }
            }
        }).store(in: &subscriptions)
        
        view.otherActionTapped.sink(receiveValue: { _ in
            if self.views.count != 0 {
                self.views.forEach {
                    $0.goToCenter()
                }
            }
        }).store(in: &subscriptions)
    }
}



public class SWViewModel: ObservableObject {
    let id: UUID = UUID.init()
    @Published var state: ViewState {
        didSet {
            if state != .center {
                self.stateDidChange.send(self)
            }
        }
    }
    
    @Published var onChangeSwipe: OnChangeSwipe = .noChange
    @Published var dragOffset: CGSize
    
    let stateDidChange = PassthroughSubject<SWViewModel, Never>()
    let otherActionTapped = PassthroughSubject<Bool, Never>()
    
    init(state: ViewState, size: CGSize) {
        self.state = state
        self.dragOffset = size
    }
    
    public func otherTapped(){
        self.otherActionTapped.send(true)
    }
    
    public func goToCenter(){
        self.dragOffset = .zero
        self.state = .center
        self.onChangeSwipe = .noChange
    }
}


public struct Action: Identifiable {
    public init(title: String, iconName: String, bgColor: Color, action: @escaping () -> ()?) {
        self.title = title
        self.iconName = iconName
        self.bgColor = bgColor
        self.action = action
    }
    
    public let id: UUID = UUID.init()
    let title: String
    let iconName: String
    let bgColor: Color
    let action: () -> ()?
}

open class EditActionsVM: ObservableObject {
    let actions: [Action]
    public init(_ actions: [Action], maxActions: Int) {
        self.actions = Array(actions.prefix(maxActions))
    }
}


enum ActionSide: CaseIterable {
    case left
    case right
}

public struct EditActions: View {
    
    @ObservedObject var viewModel: EditActionsVM
    @Binding var offset: CGSize
    @Binding var state: ViewState
    @Binding var onChangeSwipe: OnChangeSwipe
    @State var side: ActionSide
    @State var rounded: Bool
    
    
    fileprivate func makeActionView(_ action: Action, height: CGFloat) -> some View {
        return VStack (alignment: .center, spacing: 0){
            #if os(macOS)
            Image(action.iconName)
                .font(.system(size: 20))
                .padding(.bottom, 8)
            #endif
            #if os(iOS)
            if getWidth() > 35 {
                Image(systemName: action.iconName)
                    .font(.system(size: 20))
                    .padding(.bottom, 8)
                    .opacity(getWidth() < 30 ? 0.1 : 1 )
            }
            
            #endif
            if viewModel.actions.count < 4 && height > 50 {
                
                Text(getWidth() > 70 ? action.title : "")
                    .font(.system(size: 10, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                    .frame(width: 80)
            }
        }
        .padding()
        .frame(width: getWidth(), height: height)
        .background(action.bgColor.opacity(getWidth() < 30 ? 0.1 : 1 ))
        .cornerRadius(rounded ? 10 : 0)
        
    }
    private func getWidth() -> CGFloat {
        
        let width = CGFloat(offset.width / CGFloat(viewModel.actions.count))
        // - left / + right
        switch side {
        case .left:
            if width < 0 {
                return addPaddingsIfNeeded(width: abs(width))
            } else {
                return 0
            }
        case .right:
            if width > 0 {
                return addPaddingsIfNeeded(width: abs(width))
            } else {
                return 0
            }
        }
        
    }
    
    private func addPaddingsIfNeeded(width:CGFloat) -> CGFloat {
        if rounded {
            return width - 5 > 0 ? width - 5 : 0
        } else {
            return width
        }
    }
    
    private func makeView(_ geometry: GeometryProxy) -> some View {
        #if DEBUG
        //print("EditActions: = \(geometry.size.width) , \(geometry.size.height)")
        #endif
        
        return HStack(alignment: .center, spacing: rounded ? 5 : 0) {
            ForEach(viewModel.actions) { action in
                Button(action: {
                    action.action()
                    
                    withAnimation(.easeOut) {
                        self.offset = CGSize.zero
                        self.state = .center
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        withAnimation(Animation.easeOut) {
                            if self.state == .center {
                                self.onChangeSwipe = .noChange
                            }
                        }
                    }
                    
                }, label: {
                    #if os(iOS)
                    self.makeActionView(action, height: geometry.size.height)
                        .accentColor(.white)
                    #endif
                    
                    #if os(macOS)
                    self.makeActionView(action, height: geometry.size.height)
                        .colorMultiply(.white)
                    #endif

                    
                })
            }
        }
    }
    
    public var body: some View {
        
        GeometryReader { reader in
            HStack {
                if self.side == .left { Spacer () }
                
                self.makeView(reader)
                
                if self.side == .right { Spacer () }
            }
            
        }
    }
}


public enum ViewState: CaseIterable {
    case left
    case right
    case center
}

enum OnChangeSwipe {
    case leftStarted
    case rightStarted
    case noChange
}

public struct SwipeableView<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel: SWViewModel
    var container: SwManager?
    var rounded: Bool
    var leftActions: EditActionsVM
    var rightActions: EditActionsVM
    let content: Content
    
    @State var finishedOffset: CGSize = .zero
    
    public init(@ViewBuilder content: () -> Content, leftActions: [Action], rightActions: [Action], rounded: Bool = false, container: SwManager? = nil ) {
        
        self.content = content()
        self.leftActions = EditActionsVM(leftActions, maxActions: leftActions.count)
            self.rightActions = EditActionsVM(rightActions, maxActions: rightActions.count)
        self.rounded = rounded
        
//        self.content = content()
//                self.leftActions = EditActionsVM( NSLocale.current.languageCode == "ar" ? rightActions : leftActions, maxActions: NSLocale.current.languageCode == "ar" ? rightActions.count: leftActions.count)
//                self.rightActions = EditActionsVM(NSLocale.current.languageCode == "ar" ? leftActions : rightActions, maxActions: NSLocale.current.languageCode == "ar" ? leftActions.count : rightActions.count)
        
        viewModel = SWViewModel(state: .center, size: .zero)
        self.container = container
        
        container?.addView(viewModel)
        
        
    }
    
    private func makeView(_ geometry: GeometryProxy) -> some View {
        return content.environment(\.layoutDirection, NSLocale.current.languageCode == "ar" ? .rightToLeft: .leftToRight)
    }
    
    public var body: some View {
        
        let dragGesture = DragGesture(minimumDistance: 1.0, coordinateSpace: .global)
            .onChanged(self.onChanged(value:))
            .onEnded(self.onEnded(value:))
        
        return GeometryReader { reader in
            self.makeLeftActions()
            self.makeView(reader)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .offset(x: self.viewModel.dragOffset.width)
                .zIndex(100)
                .onTapGesture(count: 1, perform: { self.toCenterWithAnimation()})
                .highPriorityGesture( dragGesture )
            self.makeRightActions()
        }
    }
    
    private func makeRightActions() -> AnyView {
        
        return AnyView(EditActions(viewModel: rightActions,
                                   offset: .init(get: {self.viewModel.dragOffset}, set: {self.viewModel.dragOffset = $0}),
                                   state: .init(get: {self.viewModel.state}, set: {self.viewModel.state = $0}),
                                   onChangeSwipe: .init(get: {self.viewModel.onChangeSwipe}, set: {self.viewModel.onChangeSwipe = $0}),
                                   side: .right,
                                   rounded: rounded)
                        .animation(.easeInOut))
    }
    
    private func makeLeftActions() -> AnyView {
        
        return AnyView(EditActions(viewModel: leftActions,
                                   offset: .init(get: {self.viewModel.dragOffset}, set: {self.viewModel.dragOffset = $0}),
                                   state: .init(get: {self.viewModel.state}, set: {self.viewModel.state = $0}),
                                   onChangeSwipe: .init(get: {self.viewModel.onChangeSwipe}, set: {self.viewModel.onChangeSwipe = $0}),
                                   side: .left,
                                   rounded: rounded)
                        .animation(.easeInOut))
    }
    
    private func toCenterWithAnimation() {
        withAnimation(.easeOut) {
            self.viewModel.dragOffset = CGSize.zero
            self.viewModel.state = .center
            self.viewModel.onChangeSwipe = .noChange
            self.viewModel.otherTapped()
        }
    }
    
    private func onChanged(value: DragGesture.Value) {
        
        if self.viewModel.state == .center {
            
            if value.translation.width <= 0  {
                self.viewModel.onChangeSwipe = .leftStarted
                self.viewModel.dragOffset.width = value.translation.width
                
            } else if self.viewModel.dragOffset.width >= 0 {

                self.viewModel.onChangeSwipe = .rightStarted
                self.viewModel.dragOffset.width = value.translation.width
            }
        } else {
            // print(value.translation.width)
            if self.viewModel.dragOffset.width != .zero {
                self.viewModel.dragOffset.width = finishedOffset.width + value.translation.width
                //  print(self.viewModel.dragOffset.width)
            } else {
                self.viewModel.onChangeSwipe = .noChange
                self.viewModel.state = .center
            }
        }
    }
    
    private func onEnded(value: DragGesture.Value) {
        
        finishedOffset = value.translation
        
        if self.viewModel.dragOffset.width <= 0 {
            // left
            if self.viewModel.state == .center && value.translation.width <= -50 {
                
                var offset = (CGFloat(min(4, self.leftActions.actions.count)) * -80)
                
                if self.rounded {
                    offset -= CGFloat(min(4, self.leftActions.actions.count)) * 5
                }
                withAnimation(.easeOut) {
                    self.viewModel.dragOffset = CGSize.init(width: offset, height: 0)
                    self.viewModel.state = .left
                }
                
            } else {
                self.toCenterWithAnimation()
                finishedOffset = .zero
            }
            
            
        } else if self.viewModel.dragOffset.width >= 0 {
            // right
            if self.viewModel.state == .center && value.translation.width > 50{
                
                var offset = (CGFloat(min(4, self.rightActions.actions.count)) * +80)
                if self.rounded {
                    offset += CGFloat(min(4, self.rightActions.actions.count)) * 5
                }
                withAnimation(.easeOut) {
                    self.viewModel.dragOffset = (CGSize.init(width: offset, height: 0))
                    self.viewModel.state = .right
                }
            } else {
                self.toCenterWithAnimation()
            }
        }
    }
    
    
}

@available(iOS 14.0, *)
struct SwipebleView_Previews: PreviewProvider {
    @ObservedObject static var container = SwManager()
    static var previews: some View {
        
        let left = [
            Action(title: "Note", iconName: "pencil", bgColor: .red, action: {}),
            Action(title: "Edit doc", iconName: "doc.text", bgColor: .yellow, action: {}),
            Action(title: "New doc", iconName: "doc.text.fill", bgColor: .green, action: {})
        ]
        
        let right = [
            Action(title: "Note", iconName: "pencil", bgColor: .blue, action: {}),
            Action(title: "Edit doc", iconName: "doc.text", bgColor: .yellow, action: {})
        ]
        
        return GeometryReader { reader in
            VStack {
                Spacer()
                HStack {
                    Text("Independed view:")
                        .bold()
                    Spacer()
                }
                SwipeableView(content: {
                    GroupBox {
                        Text("View content")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                },
                leftActions: left,
                rightActions: right,
                rounded: true
                ).frame(height: 90)
                HStack {
                    Text("Container:")
                        .bold()
                    Spacer()
                }
                
                
                SwipeableView(content: {
                    Text("View content")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.blue.opacity(0.5))
                },
                leftActions: left,
                rightActions: right,
                rounded: false,
                container: container
                ).frame(height: 90)
                
                SwipeableView(content: {
                    Text("View content")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.blue.opacity(0.5))
                },
                leftActions: left,
                rightActions: right,
                rounded: false,
                container: container
                ).frame(height: 90)
                
                Spacer()
            }.padding()
        }
        
    }
}
