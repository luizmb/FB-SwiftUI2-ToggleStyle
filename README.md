# ToggleStyle issue (Feedback Assistant)

## Important:
FB8543755
Fixed on Xcode 12.2 beta4 and Xcode 12.3 beta1 (on their respective default simulators).

---

## Steps to reproduce:
- Run the project in any simulator using iOS 14 beta 6
- Change all four toggles
- Although all of them work (bindings are being changed, as seen on Form footer), the third won't visually represent the right state

![Toggle Issue](FB.png)

## Reason:
- If the ToggleStyle struct has any `@State` or `@Environment` variable, the toggle will simply not work
- An alternative to make it work is to use `func makeBody(configuration: Self.Configuration) -> some View` return an external view, which then can hold `@State` or `@Environment`, as seen on fourth toggle example.

## Important:
This was first discovered on iOS 14 beta 6.