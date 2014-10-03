// This is the simplest method I can think of hooking up the codex functions into the tree structure for display
// It's janky as fuck, but it does work, at it means the actual codex "body" content can be done almost exactly
// like regular scenes are now.

public function configureCodex():void
{
	// Complex path tree entries DO work, but until we actually NEED to organise the data
	// (and I implement some kind of path folding), I don't think we should actually USE them more than say 1 deep (because the way addEntry works
	// requires at least a "root" path of some sort
	// At the very least, the "tree" view down the side of the UI supports scrolling, so its not a HUGE issue and it
	// can wait until we're at a point it needs to be fixed.
	
	// Other types of entries -- these are categorised under separate headings
	//CodexManager.addCodexEntry(CodexManager.CODEX_TYPE_PERSON, "Test People", "Arty", testPersonEntryA);
	//CodexManager.addCodexEntry(CodexManager.CODEX_TYPE_EVENT, "Test Events", "Buttsunder", testEventEntryA);
	//CodexManager.addCodexEntry(CodexManager.CODEX_TYPE_LOCATION, "Some/Complex/Path/To", "Tentacool", testLocationEntryA);
	
	// This is how I'm proposing we split things up for now -- stuff things into a root category of the relevent system they belong too -- "Organic" etc might be a better long-term solution, but there'll be a lot
	// of categories that likely won't be very full for a LONG time going down that route
	//CodexManager.addCodexEntry(CodexManager.CODEX_TYPE_RACE, "Ara Ara", "Zil", zilCodexEntry);
	//CodexManager.addCodexEntry(CodexManager.CODEX_TYPE_RACE, "Core Worlds", "Ausar", ausarCodexEntry, true);
	//CodexManager.addCodexEntry(CodexManager.CODEX_TYPE_RACE, "Ara Ara", "Mimbrane", mimbraneCodexEntry, true);
	//CodexManager.addCodexEntry(CodexManager.CODEX_TYPE_RACE, "Unknown", "Myrmedion", myrmedionCodexEntry, true);
	//CodexManager.addCodexEntry(CodexManager.CODEX_TYPE_RACE, "Ara Ara", "Venus Pitcher", venusPitcherCodexEntry);
	//CodexManager.addCodexEntry(CodexManager.CODEX_TYPE_RACE, "Ara Ara", "Cunt Snake", cuntSnakeCodexEntry);
	//CodexManager.addCodexEntry(CodexManager.CODEX_TYPE_RACE, "Ara Ara", "Naleen", naleenCodexEntry);
	//CodexManager.addCodexEntry(CodexManager.CODEX_TYPE_RACE, "Core Worlds","V-Ko",VKoCodex);
	//CodexManager.addCodexEntry(CodexManager.CODEX_TYPE_RACE, "Core Worlds","Rahn",rahnCodexEntry);
	//CodexManager.addCodexEntry(CodexManager.CODEX_TYPE_RACE, "Tarkus","Raskvel",raskVelCodexEntry);
	//CodexManager.addCodexEntry(CodexManager.CODEX_TYPE_RACE, "Tarkus","Gray Goo",grayGooCodex);
	//CodexManager.addCodexEntry(CodexManager.CODEX_TYPE_RACE, "Tarkus","Lapinara",lapinaraCodexEntry);
	//CodexManager.addCodexEntry(CodexManager.CODEX_TYPE_RACE, "Tarkus","Sydian",sydianCodexEntry);
	//CodexManager.addCodexEntry(CodexManager.CODEX_TYPE_ITEM, "Illegal Items","Dumbfuck",dumbfuckCodexEntry);
	//CodexManager.addCodexEntry(CodexManager.CODEX_TYPE_ITEM, "Illegal Items","The Treatment",treatmentCodexEntry);
	//CodexManager.addCodexEntry(CodexManager.CODEX_TYPE_RACE, "Core Worlds","Laquine",laquineCodexEntry);
	//CodexManager.addCodexEntry(CodexManager.CODEX_TYPE_RACE, "Ara Ara", "Vanae", vanaeCodexEntry);
	//CodexManager.addCodexEntry(CodexManager.CODEX_TYPE_RACE, "Ara Ara", "Vanae: History", vanaeHistoryCodexEntry);
	//CodexManager.addCodexEntry(CodexManager.CODEX_TYPE_RACE, "Core Worlds","Leithan",leithanCodexEntry);
	
	CodexManager.addCodexEntry(CodexManager.CODEX_TYPE_PERSON, "Kara Volke", karaVolkeCodex);
	CodexManager.addCodexEntry(CodexManager.CODEX_TYPE_PERSON, "Pyra", pyraCodex);
	CodexManager.addCodexEntry(CodexManager.CODEX_TYPE_PERSON, "Logan", loganCodex);
	CodexManager.addCodexEntry(CodexManager.CODEX_TYPE_PERSON, "Tarik", tarikCodex);
	CodexManager.addCodexEntry(CodexManager.CODEX_TYPE_PERSON, "Captain Mirian Bragga", mirianCodex);
	CodexManager.addCodexEntry(CodexManager.CODEX_TYPE_PERSON, "Rourke Blackstar", rourkeCodex);
	CodexManager.addCodexEntry(CodexManager.CODEX_TYPE_PERSON, "Black Void Pirates", blackVoidCodex);
	CodexManager.addCodexEntry(CodexManager.CODEX_TYPE_PERSON, "Security Droids", securityDroidsCodex);
	
	CodexManager.addCodexEntry(CodexManager.CODEX_TYPE_ITEM, "The Silence", theSilenceCodex);
	
	CodexManager.addCodexEntry(CodexManager.CODEX_TYPE_PERSON, "Nova Securities", novaSecuritiesCodex);
}

public function codexHomeFunction():void
{
	// Written in style of technical documentation because why not.
	clearOutputCodex();
	outputCodex("Welcome to the Steele Industries® Computerised Observational Directory of Environmental eXposure® (CODEX™), version 12b.");
	outputCodex("\n\nThe Steele Industries® CODEX™ system has been designed to provide emergency-level informative warnings of Class 4 environmental and Class M biological hazards to a designated user of the device and will notify the user should the CODEX™ device detect such a hazard within a defined unsafe radius.");
	outputCodex("\n\nSystem usability has been designed for rapid dissemination of information to the designated user when facing potentially life threatening situations. The following QuickStart™ documentation is always available from the CODEX™ root menu:");
	
	outputCodex("\n\nThe buttons displayed along the bottom edge of the CODEX™ display access the core information stores offered as part of the CODEX™ devices databases.");

	outputCodex("\n\nA more detailed menu for each of the core databases is displayed to the right of the main display. Each header acts as a button to filter available records according to type.");

	outputCodex("\n\nAll displayed elements are color coded for ease of use and to ensure that the CODEX™ devices designated user can locate the information they require in a timely fashion.");
	outputCodex("\n\t<span class='new'>\\\[New Entries\\\]</span> are yellow.");
	outputCodex("\n\t<span class='viewed'>\\\[Viewed Entries\\\]</span> are white.");
	outputCodex("\n\t<span class='locked'>\\\[Missing Entries\\\]</span> are red.");
	outputCodex("\n\t<span class='active'>\\\[Active Entries\\\]</span> are blue.");

	outputCodex("\n\nSteele Industries® would like to thank [pc.name] for additionally equipping this CODEX™ device with the the following optional modules:");
	outputCodex("\n\tSteele Industries® Resource Acquisition System™ (RAS™)");
	outputCodex("\n\tSteele Industries® Automated Fringe Classifier™ (ScanNow™)");
	outputCodex("\n\tSteele Industries® Biosign Monitor Alerting™ (MedSign™)");
	outputCodex("\n\tSteele Industries® LIDAR Positioning System™ (L3P™)");

	outputCodex("\n\nOptional module documentation has been provided and loaded into the CODEX™ documentation databases. For more information, please review the optional module documentation at your earliest convenience.");
	outputCodex("\n\nCODEX-12b ready for user input.");

	userInterface.outputCodex();
}

public function karaVolkeCodex():void
{
	clearOutputCodex();
	outputCodex(header("Kara Volke"));
	outputCodex(blockHeader("- Kaithrit Master Theif"));
	
	outputCodex("You were born a slave on the world of Kahassin, outside the United Galactic Confederacy's borders. Raised in chains because of a quirk of birth, you escaped thanks to the smuggler Rourke Blackstar. He taught you the tools of the trade, became your lover and, a few months ago, sacrificed himself so you and the crew of the Silence could escape. You've since become captain, and lead this rag-tag band of outlaws in your mentor's stead. The crew is still getting used to your leadership, but they know what Blackstar thought of you, and that's been enough to keep them in line. Whether you intend to live up to Blackstar's legacy or carve your own legend, your story is just beginning!");
}

public function pyraCodex():void
{
	clearOutputCodex();
	outputCodex(header("Pyra"));
	outputCodex(blockHeader("- Raskvel Mechanic"));
	
	outputCodex("Pyra's... different. She came on board without invitation, scrambling up through one of the exhaust ports. When Blackstar caught her, she said she'd come aboard when she saw the Silence's shield generator. Because it was broken, and needed fixing. Sure enough, if you'd tried to leave atmos, it would have been crispy catgirl and crew for sure. Raskvel -- that's her species -- have a weird obsession with broken tech, and Pyra's the best damn mechanic you could ask for on a budget of the occasional roll in the hay and a few protein cubes. She's a little abrasive, but ever since your last engineer, Irish, got pinched on New Texas, she's kept the ship running like new. Or as new as the Silence ever was.");
}

public function loganCodex():void
{
	clearOutputCodex();
	outputCodex(header("Logan"));
	outputCodex(blockHeader("- Human Mod Addict"));
	
	outputCodex("Logan's the best pilot you've ever seen. She was also the best starfighter ace the Coalition fleet had, until they busted her for mod abuse and theft. She's an addict, hooked on Throbb and reptilian genetic modifications, but you've never seen it get in the way of her job... so long as you keep the cash coming in so she can keep getting at her needles. Logan is your closest friend on the Silence's crew, and frequent lover. She's a bit twitchy, and can be downright ruthless at times... and you'd never call her <i>reliable</i>... but Logan's proved a capable executive officer during your command, and continues to get you out of even the most desperate scrapes in one piece.");
}

public function tarikCodex():void
{
	clearOutputCodex();
	outputCodex(header("Tarik"));
	outputCodex(blockheader("- Naleen Brawler"));
	
	outputCodex("Tarik's the newest addition to the crew. A few weeks ago, you knocked over a freighter convoy heading to Tavros, and lo and behold, found a cargo full of exotic xeno slaves. You freed them -- you of all people know what it's like to live in a collar, after all. You didn't come away from the job with a profit, thanks to that, but you did get Tarik: a slave meant for the gladiator rings of Thallisus. When you rescued him, the big bastard swore some kind of oath of service to you. What's the difference between that and slavery? Still, it doesn't hurt to have a huge bruiser with an axe on the crew, especially when he can rip most folk in half with his bare hands. At least, that's what he says he can do... and you don't doubt him.");
}

public function mirianCodex():void
{
	clearOutputCodex();
	outputCodex(header("Captain Mirian Brigga"));
	outputCodex(blockHeader("- Human Pirate Lord"));
	
	outputCodex("Miri Bragga. The Corsair. Reaver of the Ardent Rings. This bitch is seriously bad news, one of the most famous pirates in the galaxy. Worse, she's the vanguard for the Black Void, the biggest crime syndicate in Confederate space. To put it lightly: you don't want to get on her bad side. Bragga commands the Black Rose, a heavy frigate that could give an ausar cruiser a run for its money in sheer speed and firepower. It tore the Nova Security convoy to pieces all by itself, six against one. Beating her will be damn near impossible. Escape? Unlikely. But it's the best shot you've got.");
}

public function rourkeCodex():void
{
	clearOutputCodex();
	outputCodex(header("Rourke Blackstar"));
	outputCodex(blockHeader("- Human Swashbuckler"));
	
	outputCodex("Rourke Brenner, better known by the alias Blackstar, was a famous pirate, smuggler, and outlaw. He lived flamboyantly, a rockstar of the galactic rim. Blackstar liked to think of himself as a modern day Robin Hood, but you always pegged him more like one of the gunfighters from those Old West movies he loved. The man who blew into town, shot the bad men (or at least, the men worse than him), and got the girl at the end. Got you. He saved you from slavery on your homeworld, and took you in as part of his crew. In one day, he showed you more kindness than your own race had in eighteen years."); 

	outputCodex("\n\nAnd now he's gone.");
}

public function blackVoidCodex():void
{
	clearOutputCodex();
	outputCodex(header("The Black Void"));
	outputCodex("The Black Void pirates are the nastiest, biggest group of rogues on the frontier -- and the core, for that matter. They've sunk their talons into damn near everything, from gambling and prostitution on high-wealth Confederate worlds to outright space lane piracy out on the rush worlds. You've dealt with them before -- smugglers and pirates have a natural sort of codependance -- though you'd never work for them again if you could help it. The Void is ruthless, and they hold a grudge across all the stars. They usually hunt in wolf packs of small ships, corvettes and re-purposed heavy freighters, to take down cargo craft. Lone ships attacking an armed convoy? What the hell is going on?");
}

public function securityDroidsCodex():void
{
	clearOutputCodex();
	outputCodex(header("Security Droids"));
	outputCodex("Basic security droids are ubiquitous across Confederate space. Loaded with the most rudimentary Friend/Foe ID system, small arms controls, and basic tactical movement routines money can buy in bulk, security droids provide area defense and can repel boarders on ships without having to pay living, breathing security personnel. Most security droids are cheap, effective enough at stopping open attackers, and are completely expendable. You've dealt with dozens of them over the course of your career, and they're pretty damn easy to bypass if you're stealthy, or one-shot takedown if you're in a pinch. Overall, only a threat in bulk. Lucky for you, Nova's got the budget to buy them by the container-full. ");
}

public function theSilenceCodex():void
{
	clearOutputCodex();
	outputCodex(header("The Silence"));
	
	outputCodex("The Silence. Your home. She's a sleek light freighter stroke pleasure yacht owned by the famous outlaw Rourke Blackstar, converted for a high cargo capacity, heavy shielding, and speed like you wouldn't believe. The Silence was the first taste of the greater galaxy you ever got as a mere breeder slave on your homeworld, and it whisked you away to the stars. She's the best ship in the 'verse as far as you're concerned.");
	
	outputCodex(blockHeader("Armaments & Equipment");
	outputCodex("2x Reaper Industries Twin-linked Forward Firing Laser Cannons");
	outputCodex("\n2x Reaper Industries Light Laser Turrets");
	outputCodex("\n1x Steele Tech Vanguard-XXVII Missile System");
	outputCodex("\n\nKihaCorp <i>Excelsior-class</i> Light Drive Engine");
	outputCodex("\nJoyCo Milspec Crusader Shield Generator");
	outputCodex("\nStalwart Defense Co. Light Armor Plating");
}

public function novaSecuritiesCodex():void
{
	clearOutputCodex();
	outputCodex(header("Nova Securities"));
	
	outputCodex("Nova securities is THE ubiquitous private security organization of the galactic frontier. Large, well-funded, and blessed with minimal Confederate oversight, Nova has grown from backwater planetary bodyguards to a massive paramilitary with ships and manpower to rival some planets' standing armies. Nova Securities operate as mercenaries for frontier worlds, guards for wealthy Mega Corporations and bodyguards for billionaire playboys. Most Nova operators are ex-military, especially their officers, and many have battle experience. Moreover, their equipment is state of the art, both for ground personnel and aboard their ships. Overall, they're a dangerous opponent that you've gotten on the bad side of more than once, and every time they've given you a run for your money.");
}