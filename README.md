
# Framework

Skrypt został stworzony pod framework: **[ESX Legacy](https://github.com/esx-framework/esx-legacy)**.


# Config
Skrypt jest konfigurowalny. Należy użyć pliku
```Config.lua```

# Setup

## SQL

Należy wgrać plik ```baza.sql```

## ESX

#Należy przerobić es_extended:

xPlayer - Należy dodać funkcję:
`setOrg(job, grade)`
-Należy dodać wartośći:
`xPlayer.org.name` = ID grupy
`xPlayer.org.grade` = Stopień w grupie




## Stashes

- Server-side security prevents arbitrary access to any stash.
- Support personal stashes, able to be opened with different identifiers.
- Job-restricted stashes as well as a police evidence locker.
- Server exports allow for registration of stashes from any resource (see [here](https://github.com/overextended/ox_inventory_examples/blob/main/server.lua)).
- Access small stashes via containers, such as paperbags, from using an item.
- Vehicle gloveboxes and trunks, for both owned and unowned.

## Temporary stashes

- Dumpsters, drops, and non-player vehicles.
- Loot tables allow users to find random items in dumpsters and unowned vehicles.

<br><div><h4 align='center'><a href='https://discord.gg/hmcmv3P7YW'>Discord Server</a></h4></div><br>

<table><tr><td><h3 align='center'>Legal Notices</h2></tr></td>
<tr><td>
Ox Inventory

Copyright © 2022 [Linden](https://github.com/thelindat), [Dunak](https://github.com/dunak-debug), [Luke](https://github.com/LukeWasTakenn)

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.
If not, see <https://www.gnu.org/licenses/>

</td></tr></table>
