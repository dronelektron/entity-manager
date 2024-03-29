# Entity manager

Allows you to perform various actions with objects at the beginning of the round:

* Freeze
* Delete

You can only apply actions to the following types of objects:

* prop_physics
* prop_physics_multiplayer

### Supported Games

* Day of Defeat: Source

### Installation

* Download latest [release](https://github.com/dronelektron/entity-manager/releases) (compiled for SourceMod 1.11)
* Extract "plugins" and "translations" folders to "addons/sourcemod" folder of your server

### Console Variables

* sm_entitymanager_auto_freezing - Freeze (1 - yes, 0 - no) objects at the beginning of the round [default: "1"]
* sm_entitymanager_auto_deletion - Delete (1 - yes, 0 - no) objects at the beginning of the round [default: "1"]

### Console Commands

* sm_entitymanager_freeze - Freeze the entity you are looking at
* sm_entitymanager_unfreeze - Unfreeze the entity you are looking at
* sm_entitymanager_delete - Delete entity
* sm_entitymanager_restore - Restore entity
* sm_entitymanager_show_path &lt;entity&gt; - Show path to entity
* sm_entitymanager_save - Save entities to file
* sm_entitymanager_load - Load entities from file
