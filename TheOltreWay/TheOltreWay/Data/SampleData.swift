import Foundation
import SwiftUI

// MARK: - Sample Data
/// Real content extracted from The Oltre Way dispatches.
/// Replace with API-backed content in Phase 2.
struct SampleData {

    // MARK: - Stable UUIDs for cross-referencing
    static let jacksonHoleID = UUID(uuidString: "A1B2C3D4-E5F6-7890-ABCD-EF1234567890")!
    static let banffID = UUID(uuidString: "B2C3D4E5-F6A7-8901-BCDE-F12345678901")!
    static let miamiID = UUID(uuidString: "C3D4E5F6-A7B8-9012-CDEF-123456789012")!

    // MARK: - Articles

    static let articles: [Article] = [
        jacksonHoleArticle,
        banffArticle,
        miamiArticle
    ]

    // MARK: - Jackson Hole

    static let jacksonHoleArticle = Article(
        id: jacksonHoleID,
        title: "The Hostel at the Base of the Four Seasons",
        subtitle: "On $160 ski-in/ski-out, Restaurant Week ramen, Handle Bar après, and the wealthiest zip code that feels the most like you.",
        category: .dispatches,
        heroImageName: "jackson-hole-hero",
        bodySegments: [
            .text("Jackson Hole is one of the wealthiest places in the country, and it fits me better than anywhere else I've skied in North America. I don't say this as aspiration or flex. I say it because Teton Village — the compact little base area at the foot of the mountain — has a quality I've been chasing across forty-something countries and have only found in a handful of places: it is upscale, comfortable, cosy, convenient, and not at all performative about any of it. The people here came to ski, not to be seen skiing. The restaurants are genuinely good, not \"good for a ski town.\" The Four Seasons is right there, and so is the hostel, and nobody at either one is confused about what they're doing here."),
            .text("I landed at 12:11 PM on a nonstop Alaska flight booked for 12,500 American Airlines miles. By 2 PM I had boots on. By 2:15 I was on the tram. A partial day — just the afternoon — but at Jackson Hole a partial day still gives you some of the most dramatic skiing in the lower 48, with the Tetons rising behind you in a way that photographs can't prepare you for. Besides Banff and the Dolomites, I haven't seen a mountain view from a chairlift this stunning anywhere."),
            .sectionBreak,
            .text("The trip was with my sister. We're building a travel brand together — The Oltre Way — and Jackson Hole was a content trip as much as a ski trip, though we agreed early to capture organically rather than stage anything. This was two weeks after Banff, and we hadn't yet processed the content from that trip. Sometimes the best approach to documenting a place is to just live in it and figure out what mattered later."),
            .text("We stayed at The Hostel in Teton Village. Private room. Bathroom. Ski-in/ski-out. One hundred and sixty dollars a night. This is the number that makes the rest of the trip make sense, so I'll say it again: $160 a night for a private room at the base of Jackson Hole Mountain Resort, steps from the tram, in a village where the Four Seasons charges north of $800 and Hotel Terra isn't far behind."),
            .text("The hostel is bare bones. No pool. No sauna. No robes. No minibar. Just a clean room, a bed that does its job, and a location that is — and this is the part that matters — identical to the Four Seasons. Same village. Same tram. Same walk to the same restaurants. The mountain doesn't know where you slept."),
            .pullQuote("$160 a night for ski-in/ski-out at the base of the Tetons. The rest is strategy."),
            .text("The strategy is this: the hostel saves you $200 or more per night. Over three nights, that's $600 or more that you can redirect to the things that actually define the experience of being in Jackson Hole. And so we did."),
            .text("The Gravity Haus day pass was the piece that completed it. Fifty dollars. Pool, hot tub, sauna — the recovery infrastructure that separates a good ski day from a great one, especially when you've been pushing hard terrain. After a full day on the mountain, walking from the hostel to Gravity Haus and sinking into a hot tub with the Tetons in the background felt like something a concierge would arrange at a luxury property. We arranged it ourselves, for the cost of a decent lunch."),
            .sectionBreak,
            .text("This trip coincided with Teton Village Restaurant Week, which is the kind of timing you can't plan for and shouldn't take for granted. Restaurant Week in a place like Jackson Hole means you're eating at restaurants that normally cater to the private equity crowd, at prix fixe menus that make the food accessible without diminishing it."),
            .text("Corsa — Italian, and not the kind of Italian that uses \"Italian\" as an excuse to charge $40 for pasta. Proper Italian, in a mountain town, during Restaurant Week. The kind of meal where you forget you're on a budget and then remember, with pleasant surprise, that you're not spending what you thought."),
            .text("Shin Shin — ramen. After a cold day on Jackson Hole's terrain, ramen becomes less a meal and more a medical intervention. Hot broth, noodles, the slow thaw of hands and face and core temperature. Shin Shin understands that après-ski food doesn't need to be fancy. It needs to be warm, it needs to be immediate, and it needs to meet you exactly where you are, which is exhausted and happy and salt-depleted."),
            .text("And then the Handle Bar at the Four Seasons. This is the move. The Handle Bar has the Four Seasons polish — the service, the ambiance, the wine list, the fire — without the Four Seasons room rate attached to it. You walk in from the cold, order something good, sit by the fire, and watch the Tetons through floor-to-ceiling windows while the afternoon light turns the snow pink. Nobody asks where you're staying. Nobody needs to know. The experience is the same whether you walked from the penthouse or from the hostel down the road. You're buying the après, not the address."),
            .sectionBreak,
            .text("People ask what kind of person goes to Jackson Hole. The answer has always been a specific type: affluent, performance-oriented, the Arc'teryx-everything crowd who talk about Corbet's Couloir and humble-brag about skiing the tram in whiteout conditions. Teton Village subverts this, or at least the version of it I experienced does. The village is too compact for pretension. Everything is a five-minute walk: tram, restaurants, après, done."),
            .text("I said to my sister, somewhere between the Handle Bar and the hostel, that it was fitting that the place that feels most like me is one of the wealthiest zip codes in the country. She laughed. But the observation is real: my taste runs toward places and experiences that wealthy people have identified as genuinely good — not just expensive, but good. The difference is I'm accessing it through strategy rather than capital."),
            .pullQuote("I don't want to make it work with hostels forever. The strategy is elegant now, but there's a version of this where the income matches the taste and I just book the room because I can. That's what I'm building toward."),
            .text("But for now — and I mean this without resignation, with something closer to satisfaction — the hostel at the base of the Four Seasons is not a compromise. It's a proof of concept. That the experience of a place is not locked behind the room rate. That the Tetons look exactly the same from the Handle Bar whether you slept on a $160 mattress or an $800 one."),
            .text("Jackson Hole is the kind of place that was made for people with more money than I have. I went anyway. And I didn't miss a thing.")
        ],
        practicalInfoBoxes: [
            PracticalInfo(
                title: "The Jackson Hole Stack",
                items: [
                    PracticalInfoItem(label: "$160/night", detail: "The Hostel — private room, bathroom, ski-in/ski-out"),
                    PracticalInfoItem(label: "$50", detail: "Gravity Haus day pass — pool, hot tub, sauna"),
                    PracticalInfoItem(label: "$0", detail: "Handle Bar at the Four Seasons — après-ski, no room key required"),
                    PracticalInfoItem(label: "12,500 AA miles", detail: "Nonstop Alaska flight — roughly $350 value, paid in points")
                ]
            )
        ],
        locations: [
            ArticleLocation(name: "Teton Village", latitude: 43.5877, longitude: -110.8279, note: "Base area — hostel, Four Seasons, restaurants all walkable"),
            ArticleLocation(name: "The Hostel", latitude: 43.5875, longitude: -110.8285, note: "$160/night ski-in/ski-out"),
            ArticleLocation(name: "Four Seasons Handle Bar", latitude: 43.5883, longitude: -110.8270, note: "Après-ski with Teton views — no room key needed"),
            ArticleLocation(name: "Gravity Haus", latitude: 43.5880, longitude: -110.8275, note: "$50 day pass for pool, hot tub, sauna"),
            ArticleLocation(name: "Corsa", latitude: 43.5878, longitude: -110.8282, note: "Proper Italian — Restaurant Week prix fixe"),
            ArticleLocation(name: "Shin Shin", latitude: 43.5876, longitude: -110.8277, note: "Post-ski ramen — medicinal levels of warmth"),
            ArticleLocation(name: "Jackson Hole Mountain Resort", latitude: 43.5977, longitude: -110.8490, note: "The tram, Corbet's Couloir, dramatic Teton views")
        ],
        date: dateFrom(year: 2026, month: 1, day: 20),
        estimatedReadTime: 8,
        timeGradientStops: [
            TimeGradientStop(scrollPercentage: 0.0, colorHexes: ["8A9AAC", "F5F0E8"], opacity: 0.06),
            TimeGradientStop(scrollPercentage: 0.2, colorHexes: ["6A8AAC", "E8DDD0"], opacity: 0.07),
            TimeGradientStop(scrollPercentage: 0.5, colorHexes: ["C46E4E", "C9A96E"], opacity: 0.06),
            TimeGradientStop(scrollPercentage: 0.7, colorHexes: ["D4A07A", "F2C675"], opacity: 0.08),
            TimeGradientStop(scrollPercentage: 1.0, colorHexes: ["1B2A4A", "722F37"], opacity: 0.06)
        ],
        tags: ["skiing", "jackson hole", "wyoming", "tetons", "budget luxury", "winter"],
        author: "Jonathan"
    )

    // MARK: - Banff & Lake Louise

    static let banffArticle = Article(
        id: banffID,
        title: "Record Snow and the Post Hotel Strategy",
        subtitle: "On the snowiest December in recorded history, the $40 hostel bed that unlocked everything, and learning to buy the après without the room.",
        category: .dispatches,
        heroImageName: "banff-hero",
        bodySegments: [
            .text("Banff had its snowiest December since record keeping started. I know this because I was standing inside it — waist-deep in the kind of Canadian Rockies powder that makes you forget every groomer you've ever carved, every resort you've ever called \"pretty good.\" Lake Louise in a record snow year is not pretty good. It is the kind of scenery that makes you stop mid-run and stare at the mountains like an idiot while other skiers carve around you, because the peaks are doing something with the light that no one warned you about and your phone can't capture anyway."),
            .text("We skied two days at Lake Louise and one at Banff Sunshine. The split was deliberate. Lake Louise for the views — those wide, impossible panoramas of the Canadian Rockies that make the Wasatch look like foothills — and Sunshine for the terrain, the higher elevation, the kind of snow that stays cold and dry when everything lower is already turning to cement. Three days. Two mountains. One of the best ski weekends I've had anywhere, including the Alps."),
            .sectionBreak,
            .text("Here is the part most people get wrong about ski trips to places like Banff and Lake Louise: they assume the experience requires the room. That to ski Lake Louise properly, you need to be paying four hundred dollars a night at the Fairmont, or that Banff's Post Hotel — with its legendary wine cellar and its fireside après and its immaculate Austrian-lodge atmosphere — demands you sleep there."),
            .text("It doesn't. And knowing the difference between the places that require the room and the places that only require you to walk through the door is the entire foundation of how I travel."),
            .pullQuote("The Post Hotel doesn't check your key card at the bar. They check your taste. And that's free."),
            .text("We stayed at HI Lake Louise for two nights. A hostel. The kind of place where the walls are thin and the mattress is honest about what it is and the communal kitchen smells like someone else's dinner at 11 PM. A private room with a bathroom, clean and functional and close enough to the ski area that you could be in lift line within minutes of waking up. Nothing luxurious about it. Nothing aspirational. Just a bed in the right place at the right price."),
            .text("And then, after skiing — after the kind of deep-powder day that leaves your quads burning and your face wind-chapped and your entire nervous system vibrating with that specific alpine exhaustion — we walked into the Post Hotel."),
            .text("The Post Hotel is the real thing. Not the Fairmont's grand-castle-on-the-lake performance of luxury, but the quiet, assured Austrian-lodge version — wood-paneled, warm, the kind of place where the wine list is a small novel and the fireplace has been burning since before you were born. The après scene at the Post is what people imagine when they picture \"European ski lodge experience transplanted to the Rockies.\" It's intimate without being exclusive. Refined without being precious. The bartender knows wine. The chairs are deep. The windows show you the same mountains you just skied, but from the correct angle: horizontal, drink in hand, body finally still."),
            .sectionBreak,
            .text("The third night we moved to Sunshine Mountain Lodge. One night. Ski-in/ski-out. The logic was simple: we'd done two days at Lake Louise with the hostel as base, and now we wanted to wake up on Sunshine Village itself, be first on the mountain, ski the record snow before anyone else touched it. A single night of splurge — not extravagant, just positioned — to close the trip with the one thing a hostel can't give you, which is the feeling of opening your door and being already there."),
            .text("With record snow, being first on the mountain wasn't a luxury. It was the entire point."),
            .text("There is a calculation that happens on every ski trip I take, and it goes something like this: where does paying for the room actually improve the skiing? When there's no points play, no Globalist upgrade waiting, no suite with a view that justifies the rate, I don't pay for a room I'm only going to sleep in. I pay for the experiences the room would have given me — the Post Hotel bar, the Sunshine Mountain Lodge morning — and I sleep somewhere honest."),
            .pullQuote("The scenery at Lake Louise was out of this world. Not beautiful — that word is too small. The mountains were doing something that felt personal, like they'd been waiting for the snowiest December on record just so they could show you what they actually look like."),
            .text("I keep coming back to the phrase \"out of this world\" because nothing else fits. I've skied the Dolomites, where the pink limestone at sunset makes you feel like you're on another planet. I've skied Jackson Hole, where the Tetons are so dramatic they look like a painting someone exaggerated. Banff and Lake Louise in record snow belong in that conversation."),
            .text("Two days at Lake Louise. One day at Sunshine. Three days of skiing in the snowiest December anyone can remember. A hostel, a lodge, and the Post Hotel bar. The total cost was a fraction of what most people pay for a weekend at a single resort hotel, and every dollar went exactly where it mattered."),
            .text("The mountains don't care where you sleep. They care that you showed up.")
        ],
        practicalInfoBoxes: [
            PracticalInfo(
                title: "The Banff Split",
                items: [
                    PracticalInfoItem(label: "2 nights", detail: "HI Lake Louise — private room, bathroom, proximity to slopes"),
                    PracticalInfoItem(label: "1 night", detail: "Sunshine Mountain Lodge — ski-in/ski-out, first chair with record snow"),
                    PracticalInfoItem(label: "Après", detail: "Post Hotel both Lake Louise evenings — wine, fire, atmosphere for the price of a drink")
                ]
            )
        ],
        locations: [
            ArticleLocation(name: "Lake Louise Ski Resort", latitude: 51.4254, longitude: -116.1773, note: "Impossible panoramas of the Canadian Rockies"),
            ArticleLocation(name: "Banff Sunshine Village", latitude: 51.0784, longitude: -115.7749, note: "Higher elevation, cold dry snow"),
            ArticleLocation(name: "HI Lake Louise", latitude: 51.4268, longitude: -116.1787, note: "Hostel — private room, right price, right place"),
            ArticleLocation(name: "The Post Hotel", latitude: 51.4255, longitude: -116.1800, note: "Austrian-lodge après — legendary wine cellar and fireside"),
            ArticleLocation(name: "Sunshine Mountain Lodge", latitude: 51.0750, longitude: -115.7700, note: "Ski-in/ski-out for first chair access"),
            ArticleLocation(name: "Fairmont Chateau Lake Louise", latitude: 51.4167, longitude: -116.1767, note: "The castle on the lake — grand but not required"),
            ArticleLocation(name: "Town of Banff", latitude: 51.1784, longitude: -115.5708, note: "Gateway town to the Canadian Rockies")
        ],
        date: dateFrom(year: 2026, month: 1, day: 10),
        estimatedReadTime: 7,
        timeGradientStops: [
            TimeGradientStop(scrollPercentage: 0.0, colorHexes: ["C8D8E8", "F0F4F8"], opacity: 0.06),
            TimeGradientStop(scrollPercentage: 0.3, colorHexes: ["7A9BB8", "E8DDD0"], opacity: 0.07),
            TimeGradientStop(scrollPercentage: 0.5, colorHexes: ["3A5A4A", "C9A96E"], opacity: 0.06),
            TimeGradientStop(scrollPercentage: 0.8, colorHexes: ["D4A07A", "F2C675"], opacity: 0.07),
            TimeGradientStop(scrollPercentage: 1.0, colorHexes: ["4A6B8A", "2D4A3E"], opacity: 0.05)
        ],
        tags: ["skiing", "banff", "lake louise", "canadian rockies", "powder", "winter", "budget luxury"],
        author: "Jonathan"
    )

    // MARK: - Miami Part III

    static let miamiArticle = Article(
        id: miamiID,
        title: "Tam Tam to Sunrise: The Night That Proved It",
        subtitle: "On lotus root salad at 10:45, espresso martinis at midnight, grilled cheese at 4 AM, and cotton candy clouds over Brickell at dawn.",
        category: .dispatches,
        heroImageName: "miami-hero",
        bodySegments: [
            .text("We sat down to dinner at 10:45 on a Sunday night and didn't get home until sunrise. That sounds wild if you're not from here. In Miami it's just how the night works. You eat late, you drink somewhere you didn't plan on finding, you walk into Space at 1 AM knowing full well you're not leaving until the sky turns pink."),
            .text("The whole day had been building to this. Pérez Art Museum in the afternoon. A bottle of Bordeaux at Lagniappe in the early evening. Then an hour on the balcony doing absolutely nothing, watching the bay change color from the 17th floor. That hour is the reason the rest of the night was possible."),
            .sectionBreak,
            .text("10:45 PM — Tam Tam. Vietnamese fusion on NW 1st Street. Downtown on a Sunday has this energy where everyone out is out on purpose. Tam Tam doesn't try too hard, which is exactly why it works. We ordered the lotus root salad and the wings and both were genuinely unreal. The lotus root was crisp and delicate and layered in a way you just don't expect at 11 PM. The wings were sticky and perfect. We didn't know it yet but we were fueling up for what was coming."),
            .sectionBreak,
            .text("12:00 AM — Right Hand. We found this place walking from Tam Tam to Space. Didn't plan it. A narrow cocktail bar on SE 2nd Ave with this gorgeous purple light and a farm-to-bar thing going on. We ordered three espresso martinis because we needed the caffeine more than the cocktail and honestly there's no better way to get it at midnight."),
            .text("Ten minutes earlier we didn't know this place existed. Now we're standing in purple light with espresso martinis shifting gears from dinner into whatever Space was about to be. This is what Miami does. The best things just appear between where you were and where you're going."),
            .sectionBreak,
            .text("1:00 AM — Club Space. From the outside it looks like a warehouse on NE 11th Street. Inside it's something else entirely. The sound system hits your chest before your ears catch up. The room is dark and full and alive and it erases everything outside of it. Space runs until well past sunrise and everyone in that room knows it. That changes the way you move. There's no rush. The night has hours left to unfold."),
            .text("We started on The Ground. Mama Snake and Laure Croft playing hard grooves and hypnotic techno and the sound system just swallows you whole. The Ground is the serious room. Darker, heavier, everyone fully locked in. The terrace upstairs is the opposite energy. Open sky, house music, Miami skyline behind you. You need both to do Space right."),
            .text("The first grilled cheese came around 3 AM. They sell them from a window near the floor and they're as much a part of Space as the music. This one was a pause. Just standing there eating something hot and simple while the bass kept going through the walls. A little reset before diving back in."),
            .text("We moved up to the terrace for the second half. Rony Seikaly playing house. Warm and rolling and easy to lose yourself in. The terrace is open air and at 4 AM in February the temperature is just perfect. Not thinking about anything. Not checking the time. Just there."),
            .pullQuote("The second grilled cheese was different. We weren't pausing anymore. We were dancing and eating and laughing and just fully living the Space life. That thing where the night stops being separate moments and becomes one long beautiful thing."),
            .text("There's a rhythm to Space you don't get until you've stayed long enough. The first couple hours you're adjusting. Your body calibrating to the volume and the dark and the crowd. Hours three and four are the peak. The DJs lock in. The room finds its pulse. Hour five is the grilled cheese hour. The terrace hour. The hour where everyone still there chose to be there, and you can feel it."),
            .text("We bounced between The Ground and the terrace infinity times. Down for the techno. Up for the air. Down for the bass. Up for the sky. That's what Space gives you that nowhere else in America gives you. Enough time for the night to have chapters."),
            .sectionBreak,
            .text("6:15 AM — Five minute Uber back to Brickell. Empty streets. Not abandoned, just resting. We rode in silence because after five hours of sound, silence is its own thing. Everything that just happened still settling in."),
            .text("Elevator to 17. Key card. Door. Balcony."),
            .text("Cotton candy clouds everywhere. Pink and gold across the whole sky. Every glass tower in Brickell catching the first light and reflecting it back in pieces. Key Biscayne soft and low across the water. Standing there in the clothes I'd been dancing in for five hours, looking at a sky that would look fake in a photograph, and it was the most honest thing I'd seen all weekend."),
            .pullQuote("I feel more alive in Miami than I do in La Jolla. That's not a complaint about home. Some cities just match your frequency. When you find one, you realize you'd been living with static you didn't even notice."),
            .text("Three mornings on this balcony. Friday after the red-eye standby, the bay flat and bright. Saturday at noon post-Boombox, the city already humming. Sunday at dawn with cotton candy clouds and the whole weekend written across the sky. The room cost next to nothing split three ways on points. The balcony was worth the entire trip."),
            .sectionBreak,
            .text("People talk about Miami like it's a place you go to be seen. Maybe that's South Beach on a Saturday in March. The Miami I found this weekend is something else. Lagniappe courtyards and Tam Tam lotus root and Right Hand espresso martinis and Space grilled cheeses at 4 AM. This city rewards you for staying long enough to actually see it."),
            .text("Amazonico to Lagniappe. Panamerico to Right Hand. Boombox to Space. This weekend wasn't a highlight reel. It was proof that the best travel experiences aren't planned or purchased. They're paced and surrendered to."),
            .text("I know Miami now. Not the way a tourist knows it. The way you know a city when you've found your places in it and you can feel the rhythm of its nights and the 17th floor balcony isn't just a view anymore. It's the thing that holds the whole story together."),
            .text("The flight's at 5. Time for one more Pura Vida smoothie and one more walk down a palm-lined boulevard and one more hour of beautiful nothing before going home."),
            .text("At least, that was the plan.")
        ],
        practicalInfoBoxes: [
            PracticalInfo(
                title: "The Night Arc",
                items: [
                    PracticalInfoItem(label: "10:45 PM", detail: "Tam Tam — Vietnamese fusion, lotus root salad, wings"),
                    PracticalInfoItem(label: "Midnight", detail: "Right Hand — espresso martinis in purple light"),
                    PracticalInfoItem(label: "1:00 AM", detail: "Club Space — The Ground and the terrace until sunrise"),
                    PracticalInfoItem(label: "6:15 AM", detail: "Brickell balcony — cotton candy clouds over the bay")
                ]
            )
        ],
        locations: [
            ArticleLocation(name: "Tam Tam", latitude: 25.7795, longitude: -80.1990, note: "Vietnamese fusion — lotus root salad at 10:45 PM"),
            ArticleLocation(name: "Right Hand", latitude: 25.7710, longitude: -80.1910, note: "Cocktail bar — espresso martinis in purple light"),
            ArticleLocation(name: "Club Space", latitude: 25.7860, longitude: -80.1895, note: "Warehouse on NE 11th — music until well past sunrise"),
            ArticleLocation(name: "Pérez Art Museum Miami", latitude: 25.7857, longitude: -80.1862, note: "Afternoon art before the night began"),
            ArticleLocation(name: "Lagniappe", latitude: 25.8120, longitude: -80.1930, note: "Bordeaux in the courtyard"),
            ArticleLocation(name: "Brickell", latitude: 25.7580, longitude: -80.1920, note: "17th floor balcony — cotton candy clouds at dawn")
        ],
        date: dateFrom(year: 2026, month: 2, day: 8),
        estimatedReadTime: 9,
        timeGradientStops: [
            TimeGradientStop(scrollPercentage: 0.0, colorHexes: ["C9A96E", "E8734A"], opacity: 0.08),
            TimeGradientStop(scrollPercentage: 0.15, colorHexes: ["722F37", "C46E4E"], opacity: 0.07),
            TimeGradientStop(scrollPercentage: 0.3, colorHexes: ["1B2A4A", "0A0A0F"], opacity: 0.10),
            TimeGradientStop(scrollPercentage: 0.6, colorHexes: ["0A0A0F", "1a1028"], opacity: 0.10),
            TimeGradientStop(scrollPercentage: 0.8, colorHexes: ["D4587A", "E8734A"], opacity: 0.08),
            TimeGradientStop(scrollPercentage: 1.0, colorHexes: ["F2C675", "D4587A"], opacity: 0.07)
        ],
        tags: ["miami", "nightlife", "club space", "food", "brickell", "winter"],
        author: "Jonathan"
    )

    // MARK: - Destinations

    static let destinations: [Destination] = [
        Destination(
            name: "Jackson Hole",
            region: "Wyoming, USA",
            description: "The wealthiest zip code that feels the most like you. Teton Village's compact base area delivers upscale skiing without the pretension — where the Four Seasons and the hostel share the same tram.",
            coverImageName: "jackson-hole-hero",
            latitude: 43.5877,
            longitude: -110.8279,
            articleIDs: [jacksonHoleID]
        ),
        Destination(
            name: "Banff & Lake Louise",
            region: "Alberta, Canada",
            description: "Record snow in the Canadian Rockies. Lake Louise panoramas that make the Wasatch look like foothills, the Post Hotel's legendary après, and the strategy of sleeping honest while skiing impossibly.",
            coverImageName: "banff-hero",
            latitude: 51.4254,
            longitude: -116.1773,
            articleIDs: [banffID]
        ),
        Destination(
            name: "Miami",
            region: "Florida, USA",
            description: "Tam Tam at 10:45 PM, espresso martinis at midnight, Space until sunrise. The Miami that rewards you for committing to the full arc — not South Beach performance, but Brickell balconies and cotton candy clouds at dawn.",
            coverImageName: "miami-hero",
            latitude: 25.7617,
            longitude: -80.1918,
            articleIDs: [miamiID]
        )
    ]

    // MARK: - Helpers

    private static func dateFrom(year: Int, month: Int, day: Int) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        return Calendar.current.date(from: components) ?? Date()
    }
}
