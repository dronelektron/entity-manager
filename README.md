# Entity manager

Allows you to perform various actions with objects at the beginning of the round:

* Freeze
* Delete

### Supported Games

* Day of Defeat: Source

### Installation

* Download latest [release](https://github.com/dronelektron/entity-manager/releases) (compiled for SourceMod 1.10)
* Extract "plugins" and "translations" folders to "addons/sourcemod" folder of your server

### Console Variables

* sm_entitymanager_allow_freezing - Freeze (1 - yes, 0 - no) objects at the beginning of the round [default: "1"]
* sm_entitymanager_allow_deletion - Delete (1 - yes, 0 - no) objects at the beginning of the round [default: "1"]

### Console Commands

* sm_entitymanager - Open menu
* sm_entitymanager_freeze - Freeze the entity you are looking at
* sm_entitymanager_unfreeze - Unfreeze the entity you are looking at
* sm_entitymanager_delete - Delete entity
* sm_entitymanager_restore - Restore entity
* sm_entitymanager_show_path - Show path to entities
* sm_entitymanager_save - Save entities to file
* sm_entitymanager_load - Load entities from file

### Notes

To identify objects, their **index** is used, which can change, when:

* The number of slots on the server changes
* Other plugins are creating/removing entities

In a future version of the plugin, it is planned to use a more secure method for identifying objects.
