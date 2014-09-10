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
}

public function codexHomeFunction():void
{
	// Written in style of technical documentation because why not.
	clearOutputCodex();
	userInterface.showBust("NONE");
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