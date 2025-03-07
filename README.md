# Entity manager

Allows you to perform various actions with entities:

* Freeze
* Unfreeze
* Delete (Virtually)
* Restore
* Show path
* Save entities to the file
* Load entities from the file

You can apply actions to the following types of entities:

* prop_physics
* prop_physics_override
* prop_physics_multiplayer

### Supported Games

* Day of Defeat: Source

### Requirements

* [SourceMod](https://www.sourcemod.net) 1.11 or later

### Installation

* Download latest [release](https://github.com/dronelektron/entity-manager/releases)
* Extract `plugins` and `translations` folders to `addons/sourcemod` folder of your server

### Console Commands

* sm_entitymanager - Open the menu
* sm_entitymanager_freeze - Freeze the entity you are looking at
* sm_entitymanager_unfreeze - Unfreeze the entity you are looking at
* sm_entitymanager_delete - Delete the entity you are looking at
* sm_entitymanager_restore - Restore the entity you are looking at
* sm_entitymanager_show_path &lt;hammerid&gt; - Show the path to the entity
* sm_entitymanager_save - Save entities
* sm_entitymanager_load - Load entities

### Admin Menu

Add the following to the `addons/sourcemod/configs/adminmenu_sorting.txt`:

```txt
"Menu"
{
    // Other categories

    "Entity manager"
    {
        "item"  "Freeze entity"
        "item"  "Unfreeze entity"
        "item"  "Delete entity"
        "item"  "Restore entity"
        "item"  "Show path"
        "item"  "Save entities"
        "item"  "Load entities"
    }
}
```
