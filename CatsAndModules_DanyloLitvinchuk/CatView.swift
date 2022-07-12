//
//  CatView.swift
//  CatsAndModules_DanyloLitvinchuk
//
//  Created by Danylo Litvinchuk on 23.06.2022.
//

import SwiftUI
import SDWebImageSwiftUI
import Networking
import FirebasePerformance
import FirebaseCrashlytics

struct CatView: View {
    
    private var cat: Cat
    private var paginationClosure: (() -> Void)?
    private let trace = Performance.startTrace(name: "IMAGE_DISPLAYING_TRACE")
    
    public init(cat: Cat, paginationClosure: (() -> Void)? = nil) {
        self.cat = cat
        self.paginationClosure = paginationClosure
    }
    
    var body: some View {
        WebImage(url: URL(string: self.cat.url))
            .placeholder {
                ProgressView()
                    .frame(width: 300, height: 300, alignment: .center)
            }
            .resizable()
            .scaledToFit()
            .onAppear {
                self.trace?.stop()
                Crashlytics.crashlytics().log("image \(self.cat.url) appeared")
                if let paginationClosure = paginationClosure {
                    paginationClosure()
                }
            }
    }
}

/*struct CatView_Previews: PreviewProvider {
    static var previews: some View {
        CatView()
    }
}*/
