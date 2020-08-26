//
//  ContentView.swift
//  ToggleStyleIssue
//
//  Created by Luiz Rodrigo Martins Barbosa on 26.08.20.
//

import SwiftUI

struct ContentView: View {
    @State private var firstToggle: Bool = false
    @State private var secondToggle: Bool = false
    @State private var thirdToggle: Bool = false
    @State private var fourthToggle: Bool = false

    var body: some View {
        Form {
            Section(footer: Text("1st is \(firstToggle ? "on" : "off"), 2nd is \(secondToggle ? "on" : "off"), 3rd is \(thirdToggle ? "on" : "off"), 4th is \(fourthToggle ? "on" : "off")")) {
                Toggle("Default Style", isOn: $firstToggle) // WORKING!

                Toggle("Custom Style No @State", isOn: $secondToggle) // WORKING!
                    .customStyleNoState()

                Toggle("Custom Style With @State", isOn: $thirdToggle) // *** NOT WORKING! 💥 *** (please scroll down to see why)
                    .customStyleWithState()

                Toggle("Custom Style External View", isOn: $fourthToggle) // WORKING!
                    .customStyleExternalView()
            }
        }
    }
}

extension Toggle {
    public func customStyleNoState() -> some View {
        toggleStyle(CustomToggleStyleNoState())
    }
    public func customStyleWithState() -> some View {
        toggleStyle(CustomToggleStyleWithState())
    }
    public func customStyleExternalView() -> some View {
        toggleStyle(CustomToggleStyleExternalView())
    }
}

// WORKING!
struct CustomToggleStyleNoState: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            configuration.label

            Spacer()

            Button(action: { configuration.isOn.toggle() }) {
                RoundedRectangle(cornerRadius: 15, style: .circular)
                    .fill(configuration.isOn ? Color.green : Color(white: 0.91))
                    .frame(width: 49, height: 30)
                    .overlay(
                        Circle()
                            .fill(Color.white)
                            .shadow(radius: 1, x: 0, y: 1)
                            .padding(2)
                            .offset(x: configuration.isOn ? 10 : -10)
                    )
                    .animation(Animation.easeInOut(duration: 0.1))
            }
        }
    }
}

// *** NOT WORKING! 💥 ***
struct CustomToggleStyleWithState: ToggleStyle {
    @State private var someBool: Bool = false // it doesn't matter if I use it or not
    // @Environment(\.colorScheme) var colorScheme // Environment var also breaks it

    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            configuration.label

            Spacer()

            Button(action: { configuration.isOn.toggle() }) {
                RoundedRectangle(cornerRadius: 15, style: .circular)
                    .fill(configuration.isOn ? Color.green : Color(white: 0.91))
                    .frame(width: 49, height: 30)
                    .overlay(
                        Circle()
                            .fill(Color.white)
                            .shadow(radius: 1, x: 0, y: 1)
                            .padding(2)
                            .offset(x: configuration.isOn ? 10 : -10)
                    )
                    .animation(Animation.easeInOut(duration: 0.1))
            }
        }
    }
}

// WORKING!
struct CustomToggleStyleExternalView: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        CustomView(configuration: configuration)
    }

    struct CustomView: View {
        @State private var someBool: Bool = false
        let configuration: ToggleStyleConfiguration

        var body: some View {
            HStack {
                configuration.label

                Spacer()

                Button(action: { configuration.isOn.toggle() }) {
                    RoundedRectangle(cornerRadius: 15, style: .circular)
                        .fill(configuration.isOn ? Color.green : Color(white: 0.91))
                        .frame(width: 49, height: 30)
                        .overlay(
                            Circle()
                                .fill(Color.white)
                                .shadow(radius: 1, x: 0, y: 1)
                                .padding(2)
                                .offset(x: configuration.isOn ? 10 : -10)
                        )
                        .animation(Animation.easeInOut(duration: 0.1))
                }
            }
        }
    }
}
