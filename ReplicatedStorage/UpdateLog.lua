-- ReplicatedStorage.UpdateLog
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

return {
    {
        Date = "2026-11-13",
        Title = "The G36 event & the Bubble Pack",
        Features = {
            {
                Title = "The G36 event",
                Tag = "Event",
                Image = "rbxassetid://129128863330487",
                Text = "A new legendary assault rifle: unlock it in the event before anyone can get it from a case. Until <b>Sunday, November 22</b>.",
                Points = {
                    "Complete the <b>challenges</b> (kills, hood kills, Red Zone kills, 1v1 / 2v2 / 5v5 matches...) to unlock the <b>G36</b>.",
                    "Then unlock <b>3 animated camos</b>: <b>Plasma</b>, <b>Gamma</b> and <b>Chroma</b>.",
                    "No case gives the G36 during the event. After it, the G36 joins the cases.",
                    "The G36 can also be picked in <b>Ranked</b>."
                }
            },
            {
                Title = "The Bubble Pack",
                Tag = "Limited",
                Image = "rbxassetid://113451289451494",
                Text = "A limited pack all about bubbles, in the Shop until <b>Sunday, November 22</b>.",
                Points = {
                    "<b>M4 Bubble</b> skin: a toy M4 that shoots bubbles.",
                    "<b>Diver Suit</b>: wetsuit, fins and oxygen tank in <b>7 colors</b> (Wardrobe > Skins).",
                    "<b>Bubbles</b> kill effect, <b>Bubble</b> tracer and the <i>blobolb</i> kill screen.",
                    "<b>Bubble</b> gun sound, for any gun (Armory > Shot Sound).",
                    "Every item is also sold on its own and can be <b>gifted</b>. Already own some? The pack costs less."
                }
            },
            {
                Title = "Try the M4 Bubble",
                Tag = "Free",
                Text = "Test the M4 Bubble for free at the <b>Gun Store</b> shooting range.",
                Points = {
                    "Press <b>Try it</b> at the display: you borrow the M4 Bubble as long as you stay in the range.",
                    "Shoot the targets: they take hits like players, and the board counts the ones you take down."
                }
            }
        },
        Changes = {
            {
                "NEW",
                {
                    "Armory: <b>5 new gun sounds</b> (Clicky, Laser, Muffled). Click one to hear it, then buy it or gift it to a friend."
                }
            },
            {
                "IMPROVED",
                {
                    "You can reload in vehicles again (it takes twice as long).",
                    "Controller: press <b>X</b> in your inventory to drop an item.",
                    "Armory: weapon skins like the M4 Bubble have their own <b>Skins</b> section.",
                    "The <b>Launched Firework</b> kill effect doesn't fly as high anymore.",
                    "<b>Ranked</b> is fairer against lag: laggy players no longer get an edge in fights, Ranked needs less than 250 ms of average ping (Casual stays open to everyone), and it only matches nearby regions.",
                    "Inventory and safe: every car now has its own picture, shown instantly."
                }
            },
            {
                "FIXED",
                {
                    "Some players were sent back to the title screen right after picking their outfit.",
                    "Armored vehicle: you could aim and shoot straight behind you.",
                    "You could repair someone else's car.",
                    "Ranked podium: names now sit right above each statue (the Top 1's floated far too high)."
                }
            }
        }
    },
    {
        Date = "2026-11-12",
        Title = "Outfit codes, the Zone & Ranked fixes",
        Features = {
            {
                Title = "Outfit & crosshair codes",
                Tag = "New",
                Text = "Share your look with a single code.",
                Points = {
                    "<b>Wardrobe</b>: copy the code of your outfit, or paste a friend's code to wear it.",
                    "<b>Settings</b>: copy and paste <b>crosshair</b> codes."
                }
            },
            {
                Title = "The Zone",
                Tag = "Ranked & Casual",
                Text = "No more camping: every round, a red zone closes in on the fight.",
                Points = {
                    "It shrinks for <b>90 seconds</b>, down to a small circle.",
                    "Outside the zone you lose health, faster and faster.",
                    "You can hear its wall buzzing as you get close."
                }
            },
            {
                Title = "Ranked & Casual",
                Tag = "Ranked",
                Image = "rbxassetid://101042070222701",
                Text = "Fairer matches and fewer bad surprises.",
                Points = {
                    "Lost to a player who then got <b>banned for cheating</b>? You get your <b>rank points back</b>. Banned cheaters are removed from the leaderboards.",
                    "The season's <b>Top 3</b> now stand on the podium of the ranked boat.",
                    "<b>Ranked</b>: if a player disconnects, a timer shows how long they have to come back (<b>60 s</b>). If they don't, they forfeit.",
                    "<b>Casual</b>: if your opponent leaves, the match ends right away. Before 2 rounds, that win doesn't count.",
                    "Your <b>kill streak</b> now shows in matches too."
                }
            }
        },
        Changes = {
            {
                "IMPROVED",
                {
                    "Faster loading: you get into the game sooner, the rest loads in the background.",
                    "New players now start directly on a beginner server.",
                    "Fewer server switches when you join from far away.",
                    "Playing with a high ping: your shots are no longer refused.",
                    "The <b>Data</b> kill effect is bigger.",
                    "Slow phones no longer freeze for several seconds right after joining."
                }
            },
            {
                "FIXED",
                {
                    "Some players were sent back and forth between beginner and normal servers (<i>You passed the beginner test!</i>).",
                    "The E-Drink sometimes gave no effect in Ranked.",
                    "You could end up with two items in your hands at once (shots or drinks not working).",
                    "Controller: you couldn't change your weapon between Ranked rounds.",
                    "<b>PLAY AGAIN</b> sometimes brought you back to the boat without searching.",
                    "The Ranked party rank limit (one tier) was ignored when your friend was in another server."
                }
            }
        }
    },
    {
        Date = "2026-11-10",
        Title = "Reset Stats & a fairer ELO",
        Features = {
            {
                Title = "Reset Stats",
                Tag = "New",
                Image = "rbxassetid://121674241659356",
                Text = "Want a fresh start? <b>Reset Stats</b> is now in the <b>Shop</b>.",
                Points = {
                    "Puts your <b>kills</b>, <b>deaths</b>, <b>K/D</b>, <b>accuracy</b> and <b>shots</b> back to 0.",
                    "Your <b>level</b>, <b>money</b>, <b>items</b>, <b>Ranked</b> rank and <b>leaderboard</b> spots are kept."
                }
            },
            {
                Title = "Fairer ELO",
                Tag = "Ranked",
                Image = "rbxassetid://85404385800954",
                Text = "Ranked points now follow your <b>real level</b>. Your current ELO is kept.",
                Points = {
                    "Below your level you win <b>more</b> and lose <b>less</b>; above it, the other way around.",
                    "<b>2v2</b>: your team is now compared with the enemy team. No more tiny wins and big losses for the stronger teammate.",
                    "<b>Diamond</b>, <b>Ruby</b> and <b>Champion</b> are now within reach, and the very best can climb to the <b>Top 100</b> and <b>Top 1</b>.",
                    "After your placements, you start close to your real level.",
                    "Leaving a match: your 1st leave in 12 hours only counts as a loss, then <b>5</b> and <b>15</b> minute cooldowns. Not loading into a match never gives a cooldown. Current cooldowns are removed."
                }
            }
        },
        Changes = {
            {
                "IMPROVED",
                {
                    "Smoother framerate: no more freeze when a player goes down, gets back up or is hit by a car.",
                    "Smoother framerate: sun shadows update less often.",
                    "Lighter servers: less lag and fewer hitches in full servers."
                }
            },
            {
                "FIXED",
                {
                    "Your weapon is back in your hands at the start of every round (Ranked and Casual).",
                    "Players could hit each other during the map vote and the round countdown.",
                    "Some players got a <i>You left a match</i> cooldown after <b>PLAY AGAIN</b> when the next match failed to load.",
                    "The victory scene sometimes didn't play at the end of a match.",
                    "Controller: the cursor could turn on by itself during fights.",
                    "<b>Potato Graphics</b> hid ladders, fences, railings and blinds.",
                    "The leaderboard now shows your own <b>season</b> kills and deaths, like every other row."
                }
            }
        }
    },
    {
        Date = "2026-11-09",
        Title = "Ranked, the Data Pack and the Vette are here",
        Features = {
            {
                Title = "Ranked & Casual",
                Tag = "New",
                Image = "rbxassetid://85404385800954",
                Text = "New <b>1v1</b>, <b>2v2</b> and <b>5v5 Clan vs Clan</b> matches. Head to the <b>RANKED</b> spot in the Gun Shop, from a safe zone.",
                Points = {
                    "<b>Casual</b>: play every mode for fun, with no rank at stake. Win or lose, you earn XP. For 5v5, just bring a party of 5, no clan needed.",
                    "<b>Ranked</b>: unlocks after <b>10 Casual wins</b>. Play <b>4 placement matches</b>, then climb from <b>Bronze</b> to <b>Silver</b>, <b>Gold</b>, <b>Diamond</b>, <b>Ruby</b> and <b>Champion</b>.",
                    "First to <b>5 rounds</b>. Ban a map, then pick your weapon: MP5, AK, M4, M60, SPAS-12 or MK14.",
                    "Every rank unlocks its own <b>outfit</b>. The <b>Top 100</b> and the <b>Top 1</b> of the season get exclusive ones.",
                    "Leaving a Ranked match counts as a loss, plus a short ranked cooldown."
                }
            },
            {
                Title = "Data Pack",
                Tag = "Limited",
                Image = "rbxassetid://105998431045141",
                Text = "A new limited-time pack, at the top of the Shop.",
                Points = {
                    "<b>Data camo</b>: green code raining down your weapon, with its own aura.",
                    "<b>Data skin</b>: black with moving green glyphs. Find it in the <b>Skins</b> tab of the wardrobe.",
                    "<b>Data</b> kill effect, tracer and sky.",
                    "New kill screen: <i>ErroR 404.. [name] not found!</i>"
                }
            },
            {
                Title = "Vette",
                Tag = "New car",
                Image = "rbxassetid://98414013064636",
                Text = "A new mythic car, even rarer than the Lambo, now in the car crates.",
                Points = {
                    "Best odds in the <b>Mythic Crate</b>.",
                    "Supports the garage upgrades, including <b>low suspension</b>."
                }
            },
            {
                Title = "MK14",
                Tag = "Now in cases",
                Image = "rbxassetid://84774100279900",
                Text = "The MK14 event is over: the MK14 can now be won in the <b>weapon cases</b>.",
                Points = { "Now takes the <b>Drum</b> and <b>Double Drum</b>." }
            },
            {
                Title = "Secret weapons",
                Tag = "New rarity",
                Image = "rbxassetid://111379513821371",
                Text = "The <b>Riot Shield</b> and the <b>Desert Eagle</b> are no longer mythic: they are now <b>SECRET</b>, with their own black reveal."
            }
        },
        Changes = {
            {
                "CHANGED",
                {
                    "Duplicates from cases: Common to Epic give nothing, <b>Legendary</b> refunds <b>30%</b> of the case price, <b>Mythic</b> items (not weapons) refund <b>500%</b>.",
                    "Red zones now appear exactly halfway between two airdrops."
                }
            },
            {
                "IMPROVED",
                {
                    "Smoother framerate: no more stutter when players draw or holster their weapon, lighter camos and outlines at a distance.",
                    "The Armory now shows what each attachment really does (green = bonus, red = drawback).",
                    "Better server matchmaking for players outside Europe and North America.",
                    "Your cursor stays visible when you skip a case animation."
                }
            },
            {
                "FIXED",
                {
                    "Healing and E-Drinks now work when your fire key is remapped (controller and keyboard).",
                    "Crew members sometimes couldn't see a player wearing the Void skin.",
                    "The SAFE ZONE display staying on after leaving it.",
                    "Garage brakes now look different.",
                    "Airdrops can no longer be opened from inside a vehicle.",
                    "Fixed an item duplication exploit. Abusers have been corrected."
                }
            }
        }
    },
    {
        Date = "2026-11-02",
        Title = "The Void Pack, the MK14 & Red Zones are here",
        Features = {
            {
                Title = "Void Pack",
                Tag = "Limited",
                Image = "rbxassetid://93963439522549",
                Text = "A new limited-time pack, at the top of the Shop.",
                Points = {
                    "<b>Void camo</b>: an animated starfield with real depth that shifts as you move, plus a dark aura around your weapon.",
                    "<b>Void skin</b>: turns your whole character pitch black with white lightning, worn over your outfit. Find it in the new <b>Skins</b> tab of the wardrobe.",
                    "<b>Dark Matter</b> kill effect: a black orb crackling with white lightning.",
                    "<b>Void tracer</b>: white bullet trails with a black outline.",
                    "New kill screen: <i>[name] sent you into the void</i>.",
                    "<b>Void sky</b>: swap your sky for deep space."
                }
            },
            {
                Title = "MK14 EBR",
                Tag = "New weapon",
                Image = "rbxassetid://84774100279900",
                Text = "A new semi-auto battle rifle, the rarest legendary weapon in the cases.",
                Points = { "Takes attachments and camos, like the other guns." }
            },
            {
                Title = "Red Zones",
                Tag = "New",
                Text = "Every other airdrop is replaced by a red zone somewhere in the city: <b>Church</b>, <b>Downtown</b> or <b>Villas</b>.",
                Points = {
                    "Announced <b>1 minute</b> before, it lasts <b>10 minutes</b>.",
                    "Every kill inside pays <b>x1.2</b> money, on top of your kill streak.",
                    "The <b>top 3</b> win <b>$500,000</b>, <b>$250,000</b> and <b>$100,000</b> (5 kills minimum).",
                    "A kill only counts if both you and your victim are inside the zone, and never between members of the same clan or crew.",
                    "Nobody spawns inside the zone."
                }
            }
        },
        Changes = {
            {
                "IMPROVED",
                {
                    "Smoother framerate in crowded fights: other players' weapon animations cost much less.",
                    "Animated camos now play smoothly in the Armory preview."
                }
            }
        }
    }
}
