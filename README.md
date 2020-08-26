# ToggleStyle issue (Feedback Assistant)

## Steps to reproduce:
- Run the project in any simulator using iOS 14 beta 6
- Change all four toggles
- Although all of them work (bindings are being changed, as seen on Form footer), the third won't visually represent the right state

## Reason:
- If the ToggleStyle struct has any `@State` or `@Environment` variable, the toggle will simply not work
- An alternative to make it work is to use `func makeBody(configuration: Self.Configuration) -> some View` return an external view, which then can hold `@State` or `@Environment`, as seen on fourth toggle example.

## Important:
This was first discovered on iOS 14 beta 6.