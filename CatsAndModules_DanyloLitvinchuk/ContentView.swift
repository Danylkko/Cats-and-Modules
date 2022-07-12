//
//  ContentView.swift
//  CatsAndModules_DanyloLitvinchuk
//
//  Created by Danylo Litvinchuk on 19.06.2022.
//

import SwiftUI
import Networking
import SDWebImageSwiftUI
import FirebasePerformance
import FirebaseCrashlytics

struct ContentView: View {
    
    @ObservedObject var catFetcher: CatFetcher
    private static var trace = Performance.startTrace(name: "API_RESPOND_TRACE")
    
    public static let key = "IS_COLLECTION_ENABLED"
    @State private var isCollectionEnabled = !UserDefaults.standard.bool(forKey: ContentView.key)
    
    init() {
        self.catFetcher =
        CatFetcher(limit: 10) {
            ContentView.trace?.stop()
        }
    }
    
    var body: some View {
        VStack {
            NavigationView {
                ScrollView {
                    LazyVStack {
                        ForEach(self.catFetcher.cats) { cat in
                            NavigationLink {
                                VStack {
                                    Spacer()
                                    CatView(cat: cat)
                                    Spacer()
                                    Button {
                                        Crashlytics.crashlytics().setCustomValue(
                                            self.catFetcher.cats.firstIndex { $0.id == cat.id },
                                            forKey: "crash_at_picture"
                                        )
                                        fatalError("crash at discrete view")
                                    } label: {
                                        Text("🤪 Crash")
                                    }
                                    
                                }
                            } label: {
                                CatView(cat: cat) {
                                    self.catFetcher.fetchMoreCats(cat: cat)
                                }
                            }
                            .onTapGesture {
                                Crashlytics.crashlytics().setCustomValue(
                                    self.catFetcher.cats.firstIndex { $0.id == cat.id },
                                    forKey: "last_tapped_row"
                                )
                            }
                        }
                    }
                    .navigationBarHidden(true)
                    .navigationBarTitleDisplayMode(.inline)
                    .accessibilityIdentifier("mainTable")
                }
            }
            Button {
                let optionalInt: Int? = nil
                print(optionalInt!)
            } label: {
                Text("🤪 Crash")
            }
        }
        .alert(isPresented: $isCollectionEnabled, content: {
            Alert(title: Text("Privacy"),
                  message: Text("Do you agree your crash data will be collected?"),
                  primaryButton: Alert.Button.default(
                    Text("Accept"), action: {
                        UserDefaults.standard.set(true, forKey: ContentView.key)
                        Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(true)
                    }
                  ),
                  secondaryButton: Alert.Button.destructive(
                    Text("Cancel"), action: {
                        UserDefaults.standard.set(true, forKey: ContentView.key)
                        Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(false)
                    })
            )
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
