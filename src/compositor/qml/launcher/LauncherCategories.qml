/****************************************************************************
 * This file is part of Liri.
 *
 * Copyright (C) 2017 Pier Luigi Fiorini
 *
 * Author(s):
 *    Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:GPL3+$
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * $END_LICENSE$
 ***************************************************************************/

import QtQuick 2.0
import QtQuick.Controls 2.0
import Fluid.Controls 1.0 as FluidControls
import Liri.Launcher 0.1 as CppLauncher

ListView {
    signal selected(string category)

    id: root
    currentIndex: 0
    model: CppLauncher.CategoriesModel {
        id: categoriesModel
    }
    delegate: FluidControls.ListItem {
        property string category: model.category

        text: model.display
        highlighted: root.currentIndex == index
        onClicked: root.currentIndex = index
    }
    onCurrentIndexChanged: if (currentItem) root.selected(currentItem.category)

    ScrollBar.vertical: ScrollBar {}
}
