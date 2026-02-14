import SwiftUI

/// Styled card for practical information — costs, addresses, tips.
/// Visually distinct from body text with a subtle background tint.
struct PracticalInfoBoxView: View {
    let info: PracticalInfo

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Label
            Text("THE OLTRE WAY")
                .font(OltreFonts.category(9))
                .tracking(2.5)
                .foregroundColor(OltreColors.textMuted)

            // Title
            Text(info.title)
                .font(OltreFonts.medium(18))
                .foregroundColor(OltreColors.textDark)

            // Items
            VStack(alignment: .leading, spacing: 10) {
                ForEach(info.items) { item in
                    HStack(alignment: .top, spacing: 12) {
                        Text(item.label)
                            .font(OltreFonts.bold(18))
                            .foregroundColor(OltreColors.forestGreen)
                            .frame(minWidth: 60, alignment: .leading)

                        Text("—")
                            .font(OltreFonts.body(14))
                            .foregroundColor(OltreColors.textMuted.opacity(0.5))

                        Text(item.detail)
                            .font(OltreFonts.body(14))
                            .foregroundColor(OltreColors.textMuted)
                            .lineSpacing(4)
                    }
                }
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(OltreColors.cream)
        .overlay(
            Rectangle()
                .fill(OltreColors.forestGreen)
                .frame(width: 3),
            alignment: .leading
        )
    }
}
