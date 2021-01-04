require "themed_miniwindows"
require "aard_lua_extras"

local requiredVersion = 2118
local _, version, _ = aard_lua_extras.PackageVersionExtended()
local WINDOW_ID = GetPluginID()
local LPos = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
local ELPos, PTPos = 1
local Lessons = { 
	{ 
		"gt @x046Lesson 1:$C Mobdeaths command & Mapper Help",
		"gt Please check out the help mobdeaths file. Going to give you a minute to read that over.",
		"gt Using the @M'mobdeaths <low level> <high level> [good|evil|neutral]'$C can someone from this group suggest an area for us to level in? You can also use the areas command if you prefer: @M'areas <low level> <high level>'$C. We will all shift to the same alignment, so don't worry which alignment you choose.", 
		"gt A group this size can kill things levels higher than we could on our own, think that over when you consider which level ranges we should seek out. Any suggestions? :) ", 
		"gt One of the hidden gems about Mushclient is its ability to pre-set starting positions in areas, or you can automatically program in your hand-held portals. You will want to type @Mmapper help$C to start. From there, you can delve into @Mmapper help portals$C, @Mmapper help exits$C.  It is extensive. You can use @Mmapper addnotes$C to add notes to specific rooms (such as remember what you need to do in room x to get to room y or a special keyword). It’s all here! Now you never have to write anything down on paper ever again! ",
		"gt @x208That brings and end to Lesson 1$C"
	}, 
	{
		"gt @x046Lesson 2:$C How to capitalize on 'other' bonus experience",
		"gt There are several ways to get some bonus experience while leveling that don't come from double experience. One is using/practicing skills as you level, and another is by searching for rare experience found on mobs which haven't been killed in awhile.", 
		"gt Who thinks they can find us an area with rare experience to feast on? Go ahead and use the areas and/or mobdeaths command to search for another area you think we might find some rare exp in. I'll give you all a minute to think that over.", 
		"echo @GAnnounce where to meet after everyone has practiced and prepared and chosen an area.@W",
		"gt Try out some of those new skills/spells you practiced this time to get some extra bonus experience while we level here.", 
		"gt @x208That brings and end to Lesson 2$C"
	},
	{
		"gt @x046Lesson 3:$C Changing Alignment / Being Neutral",
		"gt Now we're going to shift gears and explore the value of being neutral alignment. I'm going to choose an area of an opposite align for us to change alignments in. Hang tight while I figure it out please.",
		"echo @Rfind an area and tell everyone to meet you there. Then kill things till the group is mostly neutral@W",
		"gt Could somebody suggest an area that we could level in that has both good and evil aligned mobs to stay neutral?",
		"echo @Gonce we have an area to go to get everyone to meet us there.@W",
		"gt Now that we're neutral you may notice that we're getting slightly less experience per mob than we were when we were extreme aligned as Good/Evil. That may seem like a drawback, until you see how much more damage we do. Did you notice an increase in your damage at all since we’ve been here?",
		"echo @RCan encourage conversation about how at lower levels/in large groups being neutral may be less ideal as things already die so quickly!@W",
		"gt Nominate a new leader for this group and choose an area for us to go and level in. ",
		"gt @x208That brings and end to Lesson 3$C"
	},
	{
		"gt @x046Lesson 4:$C Maledictions",
		"gt The following skills/spells are called Maledictions. They all weaken the mobs/targets in some way and can also be quite useful in PVP.",
		"gt Some maledictions are as follows: soften, raven scourge, rune of ix, blind, green death, ego whip, weaken, rainbow, hydra blood, marbu jet, daze, stun, bodycheck, sweep.",
		"gt primary class @Gmage$C, sorcerer subclass: petrify, curse of sloth, hex of entropy and hex of misfortune.; gt primary class @Gthief$C, kobold stench. Venomist subclass: balor spittle & necrotic touch.; gt primary class @Gcleric$C, harmer subclass: suppressed healing & desecration.; gt primary class @Gpaladin$C, avenger subclass: tortured vision & Righteous anger.; gt primary class @Gpsionicist$C, mentalist subclass: slow, amnesia & demoralize.",
		"gt Take a minute to check if you can practice any of those and go do that now at your trainers. We’ll use some of them as we level and you and see what they do. Feel free to change gear and restock/train/quest if you can as well. :)",
		"gt @x208That brings and end to Lesson 4$C"
	},
	{
		"gt @x046Lesson 5:$C The Value of Pets/Easier Navigation",
		"gt How many of you can use the warhorse and/or dust devil command? Go ahead and practice it now if you can. Also practice door and/or gate if you have it.",
		"gt Choose an easy to remember and easy to type name for your pet when you name them.  We can use them for easier navigation from area to area as we level. If you don’t have the skill/spells you can also adopt a pet. Check out ‘help pets’ for more info on that.",
		"gt So, where to next y'all? Suggest some areas where we can level and maintain our current alignment please.",
		"echo @GHave players set pet mobs and then move around in the area before using doorway/gate to get back to them@W",
		"gt Another use for pets is to have a huntable mob in a norecall/noportal zone to mark the exit room. Keep that in mind for upper/lower planes quests/campaigns.",
		"gt @x208That brings and end to Lesson 5$C"
	},
	{
		"gt @x046Lesson 6:$C Navigating @R[**> PK <**]$C rooms as a group",
		"gt The next lesson is on Navigating @R[**> PK <**]$C rooms as a group. Some groups will consist of players from both PK and NO-PK clans. When you have a combination, it is respectful to ask your group pals if they should avoid the PK rooms or not.",
		"gt I'm going to bring us to an area with PK rooms now and show you how to actively avoid them in case you wind up wanting to do so yourself, or if you wind up leading a group with a member who would prefer you did.",
		"gt Let's go to Tumari's Diner. ",
		"gt So, the biggest thing with avoiding PK rooms is either knowing where they are from memory, or using the '@Gexits$C' command to check for the @R[**> PK <**]$C flag. Anyone using mapper can see them by the bold red outline on the rooms of the map. So once an area is in your mapper you can spot them easier than relying on using the exits command every room.",
		"echo @G Chat about the limitations of the mapper showing PK flagged rooms. Then take them to a room next to a PK room and get them to use the exits command to spot it.@W",
		"gt If you're unfamiliar with an area, it can be advantageous to pull up a map in another window and check out the lay of an area and take note of any potential PK rooms in the area. Don't worry about doing that now though, use the '@Gexits$C' command and check out what that PK flag looks like when you do. When you see it, move around it when possible.",
		"gt if you’re considering joining a PK Clan and interested in seeing the @R[**> PK <**]$C flags in your prompt you can add that using %K.",
		"gt @x208That brings and end to Lesson 6$C"
	},
	{
		"gt @x046Lesson 7:$C The Importance of Questing/Gaining QP's",
		"gt Learning to quest regularly is a very good habit to get into early on. Quest points (QP) are going to buy you some of the best gear, bags and weapons in the game. Additionally, QP are necessary to Superhero after your first free one. QP take time to build up, but the good news is that there are lots of ways of gathering them!",
		"gt What are some of the ways that you all have earned quest points so far?",
		"echo @Gguide the group in to listing all the methods of earning qp, quest, campaigns, GQs, DB rewards, epic rewards, aardwords, poker, Aarch Pieces & Lasertag@W",
		"gt Something that a lot of older players lament is that they didn't quest and/or campaign more often, so start building those habits now and you'll be QP rich down the road. Have any of you heard of people campaign leveling?",
		"gt @GHelp newbie-aard$C might be helpful to look over before you start buying Aardwolf Equipment and/or weapons. It's a good overview on what might be important to purchase first and at what levels.",
		"gt @x208That brings and end to Lesson 7$C"
	},
	{
		"gt @x046Lesson 8:$C Using Area of Effect Spells(AOE's) or Area Attack Spells",
		"gt AOE's are Area Spell Attacks such as: ultrablast (psi), toxic cloud (mage), fire breath (mage), wrath of god (paladin), hammerswing (warrior/blacksmith) to name a few. These are spells that *hit/engage every mob in the room. There is a bit of lag at the end of the AOE command.",
		"gt Something to be aware of: *If you're not a primary class caster AOE spells cap at hitting 4 targets in the room when you cast them. Therefore, having a pclass caster AOE a room and be rescued by the tank can be a worthwhile strategy if the tank cannot AOE effectively.",
		"gt In a group where multiple people are using AOE's it can be beneficial to use a variety of them so their effects stack. Example. You use fire breath which has the chance to blind the mobs, and I'll use toxic cloud which has a chance to poison the mobs on entry.",
		"gt Does everyone here have the rescue command practiced? We're all going to need to pay attention to the leader's health bar and '@Grescue playername$C' if their health bar dips dangerously low.",
		"gt @x208That brings and end to Lesson 8$C"
	},
	{
		"gt @x046Lesson 9:$C General Clan Information",
		"gt Here's some general Clan information for you to consider. The '@Gclist$C' command shows a full list of clans on Aardwolf. You will have a chance to get to know at least a few of them today during the Festival. Ask questions, get to know members, and otherwise get a feel for what it means to be part of the Aardwolf community. :)",
		"gt Clans can be PK or NOPK. PK Clans can attack other hostile clan members in @R[**> PK <**]$C rooms. Give a thought to what kind of clan you'd prefer to be a part of when applying.  Check out '@Ghelp newbie-clan$C' for more information.",
		"gt Here's a quick list of some of the benefits to being in a Clan: Access to clan morgue, fancy clan skills, access to closed clan gear, having access to a support system in game, often provides access to a wiki/discord server full of information containing goalsolutions/guides/plugins upon joining.",
		"gt @x208That brings and end to Lesson 9$C"
	},
	{
		"gt @x046Lesson 10:$C Setting a Prompt",
		"gt Your prompt bar displays important information such a hp/mana/moves/quest time and can be customized in both feature(s) and color. We've come up with a few suggested prompts to use for the day but encourage you all to read '@Ghelp prompt$C' and to create one of your own.",
		"gt You can highlight either of the following suggested prompts. To do so in MUSH, highlight the desired text and hold '@GCtrl D$C' to copy it, colors and all! That's commonly referred to as '@Gcolorpasting$C'. You can see your existing prompt and battle prompt using the '@Gconfig$C' command.",
		"gt Suggested Prompt #1: @@W<@@CHP: %h/%H, @@GMN: %m/%M, @@gMV:%v @@wXP:%X @@WQT:%q @@MAL:%a@@W> %d %c and the matching Battleprompt: @@w< @@C%h/%p @@G%m/%P @@g%v @@MAL:%a @@DQT:@@W%q%d@@R %b%l@@w >%d %c$C",
		"gt Suggested Prompt #2: @@w<%h/%Hhp %m/%Mmn %v/%Vmv(%X)@@G[@@g %e@@G]@@w(%q)(%g)%a%d @@R%K@@w>%c and the matching Battleprompt: @@w <%h/%Hhp %m/%Mmn %v/%Vmv(%X)[%e](%q)(%g)%a%d%l %b @@R%K@@w> %c$C",
		"gt The main thing to remember when changing your prompt is to remember to put the %c at the end. A number of plugins require output, you might not see, to be on a new line and not part of your prompt line.",
		"gt @x208That brings and end to Lesson 10$C"
	}
}

local ProTips = 
{
	"gt @x046Pro-tip #1:$C Here's a quick tip to reduce battle spam. Toggling the @Gbattlespam$C command will hide damage output shown from the other group members. This is a great option for if you play on a small screen or otherwise want to minimize spam. You can also toggle the @Gspamreduce pheal$C command if you are in a large/epic group. Check out ‘help spamreduce’ for a multitude of ways to clean up your screen output.",
	"gt @x046Pro-tip #2:$C Using the @Gswho 12 area$C command will show you at a glance who is in an area ranked alongside their trained stats. This can be a useful command to macro/alias if you are Hardcore, OPK, or a part of a PK clan.",
	"gt @x046Pro-tip #3:$C Consider making macros and/or aliases to simplify commands that you use all the time. Ex. Getting potions from a bag/quaffing them, or casting your main attack(s).",
	"gt @x046Pro-tip #4:$C Using the @Gkeep$C command will prevent you from dropping or accidentally selling any items flagged/marked as kept. There is also an @Gautokeep$C command which automatically keeps items purchased from shopkeepers.",
	"gt @x046Pro-tip #5:$C Adding @Gcustom exits$C to your MUSH mapper will help you navigate Aardwolf more efficiently.",
	"gt @x046Pro-tip #6:$C You have to work on your character to get it where you want it to be. It doesn't come overnight. Growth comes on the daily by doing the things you enjoy and slowly improving your character. Try not to compare your character to that of others.",
	"gt @x046Pro-tip #7:$C MUSH Users: Hitting the tab key will auto complete your word. This is particularly useful for things like accepting group requests. You need to start typing the word before hitting tab for it to autocomplete. The word also needs to have recently appeared on the screen for it to generate the appropriate response. Ex. Gr (tab) = Group, Acc (tab) = Accept, First letters of players name (tab) = Playername should generate from the last person to have invited you.",
	"gt @x046Pro-tip #8:$C Don't hesitate to reach out to more 'experienced players'. They're people just like you. Be both respectful and descriptive in your message and you'll likely get a positive response.",
	"gt @x046Pro-tip #9:$C Aardwolf has a Wiki with additional supports available to you. One of my favourite parts is the Areas tab full of maps! Check it out if you haven't already: http://www.aardwolf.com/wiki/index.php/Area/Area",
	"gt @x046Pro-tip #10:$C After you hit T9/R7, your daily QP income is effectively capped and your QP income is time-gated by the daily CP cap and quest timer. This is not true for before that.  Considering @Gcampaign leveling$C to help you reach your QP goals sooner.",
	"gt @x046Pro-top #11:$C Many Goal rewards offer features making area navigation easier. Some will even reward you with area portals!",
	"gt @x046Pro-tip #12:$C Rumour has a youtube channel with videos covering a variety of Aardwolf topics, check out the link! https://www.youtube.com/user/AardRumour/playlists" 
}

local Etiquette =
{
	" gt Hi Everyone! We're going to go over some information on how to actively participate in leveling/pupping groups. Some of this may be familiar, and some may be new to you. Let me know if you have any questions. Here are some things to consider when participating in a group:",
	"gt Keeping yourselves, and your tank/leader healed is important. A tank is the group member who will be leading the group and initiating combat. They take the most damage and engage most frequently so we’re all going to help out with healing them.",
	"gt If you haven't already restocked potions, go ahead and do that now. You can find some heal/mana potions using the 'potsearch command' if you don't already have a favorite place to buy from. Consider making a macro/alias to quaff potions so that you can keep them in a bag to keep weight down, and get them out/quaff/eat in a single keystroke.",
	"gt Please go practice party heal or incomplete heal if you have it available and cast accordingly as we go. You can monitor your tank/leaders health in the group tab if you use MUSH. Don't worry if you don't have these spells.",
	"gt If you need to leave this group for any reason, please let us know and recall out using word of recall/recall/home. Come back once you are able to give the group your full attention. As per help Policies7, being *AFK* (Away From Keyboard) in an active group is considered -botting- as your character would be gaining experience while you are not actively engaged at the keyboard. Don't do that. Just take a break and come back when you can.",
	"gt If you are having trouble spelling up between rooms because your tank/leader is moving too quickly or you don't have enough time for your spells to recite, you can toggle 'autoass' to respell. Toggle it back after to continue attacking! You can also retreat out of the room and then rejoin the group if you prefer.",
	"gt If you use Mush, there are spellup plugins available which can help by waiting until you are no longer in battle before automatically recasting your spells that are worth considering and/or installing.",
	"gt We will stop regularly to quest, change gear and to train/prac, so feel free to leave the group to quest as needed, or if our timers sync up we can go as a team. We may take some breaks, and if you want to keep leveling there may be another group in range for you to join. You can use the 'who from mentor' command all day to find Mentor’s willing to lead/teach lessons. Tell your Boot & UnClanned friends! :)",
	"gt If we do all quest at the same time, be mindful that we might get mobs in the same areas, so watch what you kill so we don't accidentally steal other peoples' kills. If you join a GQ with a group member, it is advisable to turn 'autoassist' off and toggle 'nofollow' so you don't accidentally snatch 3qps from each other or wind up dragging each other in the wrong direction.",
	"gt It's always good to make sure you have 'autoshare' on, so that everyone gets an equal cut of the gold. Also, please keep frequent reporting triggers off gtell so you don't robot spam your buddies/us!",
	"gt Some useful commands to practice for easier grouping if they are available to you: fly/levitation/having a boat or raft in your inventory, rescue, retreat, aim, warhorse/dustdevil/adopting a pet, word of recall, door/gate, party heal, incomplete heal, dampening field/dispel magic, raven scourge, green death, rainbow, hydra blood, ego whip, soften or class specific ones!",
	"gt I'm going to give everyone time to go practice any of those skills/spells as necessary and to grab potions/restock.",
	"echo [Give them some time to practice/restock and tell them all to wait at recall and once they're all there you'll start the first lesson. Stop to train stats/practice new skills every 5 levels or so.]"
}


function Draw_Window()
	local counter
	my_window = ThemedBasicWindow(
	WINDOW_ID,
	200,
	350,
	200,
	350,
	"Mentor Weekend Lessons",
	"center",
	false)
	for i, texts in ipairs(Lessons) do
		counter = i
		my_window:add_3d_text_button(
		"LessonButton"..i,
		my_window.bodyleft + 10,
		my_window.bodytop + (i * 30) - 25,
		"Lesson "..i,
		false,
		nil,
		function(flags, button_id) Output_Lesson(nil, nil, {i}) end,
		function(flags, button_id) end,
		Dina,
		1,
		1
		)
		my_window:add_3d_text_button(
		"ResetButton"..i,
		my_window.bodyleft + 110,
		my_window.bodytop + (i * 30) - 25,
		"Reset "..i,
		false,
		nil,
		function(flags, button_id) Reset_Lesson(nil, nil, {i}) end,
		function(flags, button_id) end,
		Dina,
		1,
		1
		)
	end
	my_window:add_3d_text_button(
	"ProTipButton",
	my_window.bodyleft + 10,
	my_window.bodytop + ((counter+1) * 30) - 25,
	"Protip",
	false,
	nil,
	function(flags, button_id) Output_Protip() end,
	function(flags, button_id) end,
	Dina,
	1,
	1
	)
	my_window:add_3d_text_button(
	"ResetProTipButton",
	my_window.bodyleft + 110,
	my_window.bodytop + ((counter+1) * 30) - 25,
	"Reset",
	false,
	nil,
	function(flags, button_id) Reset_Protip() end,
	function(flags, button_id) end,
	Dina,
	1,
	1
	)


	-- Now that the size is set, auto-center the window on the screen.
	WindowPosition(WINDOW_ID, 0, 0, 6, 16)

	my_window:show()

	my_window:bring_to_front()
end

function Output_Lesson (name, line, wildcards)
	LNum = tonumber(wildcards[1])
	if LNum <= #Lessons then
		Execute(Lessons[LNum][LPos[LNum]])
		LPos[LNum] = LPos[LNum] + 1
		if LPos[LNum] > #Lessons[LNum] then
			LPos[LNum] = 1
		end
	else
		print("somehow we are out of range")
	end
end

function Reset_Lesson (name, line, wildcards)
	LNum = tonumber(wildcards[1])
	if LNum <= #Lessons then
		Execute("echo @x208Lesson "..LNum.." reset@W")
		LPos[LNum] = 1
	else
		print("somehow we are out of range")
	end
end

function Output_Etiquette()
	Execute(Etiquette[ELPos])
	ELPos = ELPos + 1
	if ELPos > #Etiquette then
		PTPos = 1
	end
end

function Reset_Etiquette()
	Execute("echo @x208Etiquette Lesson reset@W")
	ELPos = 1
end

function Output_Protip()
	Execute(ProTips[PTPos])
	PTPos = PTPos + 1
	if PTPos > #ProTips then
		PTPos = 1
	end
end

function Reset_Protip()
	Execute("echo @x208ProTips reset@W")
	PTPos = 1
end

function MW_Help()
	Note("List of commands for the Mentor Weekend Plugin")
	Note("+--------------------------------------------+")
	Note("MW help  - This help file")
	Note("OL <num> - Output Lesson <num>")
	Note("RL <num> - Reset Lesson <num>")
	Note("OT       - Output Protip")
	Note("RT       - Reset Protip")
	Note("OE       - Ouput Etiquette Lesson")
	Note("RE       - Rest Etiquette Lesson")
	Note("OS <num> - Ouput Superhero Lesson <num>")
	Note("RS <num> - Rest Superhero Lesson <num>")
	Note("+--------------------------------------------+")
end

function OnPluginInstall()
	Note("You are using r"..version.." of Mushclient")
	if tonumber(version) >= requiredVersion then
		Draw_Window()
		Note("Basic Themed Miniwindow created")
	else
		Note("Your version of Mushclient is to old to use the miniwindow but the aliases are still available")
	end
	MW_Help()
end

