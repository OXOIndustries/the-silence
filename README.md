The Silence
================

Major changes over TiTS
-----------------------

* Superclass functions are slowly being lifted out of the include/class structure and built into package-level functions under ```Classes.Engine``` - This isn't complete and there's still stuff that could be shifted. Things go over as and when I need them.

* A number of core systems that used to live inside singular included .as files have been reworked into a static-class pattern, mostly available under ```Classes.GameData```. Static classes mainly so I can wrap static initializers into their classbody to setup all of their initial state (see the seemingly open-hanging { } blocks inside these classes - they'll be run ONCE, the first time the class is actually referenced at runtime).

* Scene content has been shifted away from includes and into a static class structure under ```Classes.GameData.Content```. Content contains both room-function implementations and actual regular scenes too. Everything is based off a single parent class wrapping certain functions to make access to them "nicer" (see BaseContent.as). The breakup is far too granular, but I'm playing with ideas for certain things (see: switching out the room implementations inside the main Content index on the fly, allowing an entire locations "room descriptions" to be varied without having to build nested/complicated singular methods in one class.

* The Ships-as-Characters and Ships-as-map-object setup is fucked at the minute. It works, but it's not clear. This is something that will have to be reworked. The entire way the map handles ships is trash, but I don't need to fix it for Silence, so I'm not going to (yet).
